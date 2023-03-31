import { execSync } from 'child_process';
import {
  commands,
  Disposable,
  events,
  ExtensionContext,
  LanguageClient,
  LanguageClientOptions,
  ServerOptions,
  services,
  TextDocument,
  window,
  workspace,
} from 'coc.nvim';
import executable from 'executable';
import * as fs from 'fs-extra';
import versionCompare from 'node-version-compare';
import path from 'path';
import { Config } from './config';
import { downloadServer, getLatestRelease } from './downloader';
import { Neodev } from './neodev';

export type LuaDocument = TextDocument & { languageId: 'lua' };
export function isLuaDocument(document: TextDocument): document is LuaDocument {
  const ret = document.languageId === 'lua';
  return ret;
}

export type Cmd = (...args: any[]) => unknown;

export class Ctx {
  client!: LanguageClient;
  public readonly config = new Config();
  barTooltip = '';
  neodev!: Neodev;

  constructor(public readonly extCtx: ExtensionContext) {
    this.neodev = new Neodev(extCtx);
  }

  registerCommand(name: string, factory: (ctx: Ctx) => Cmd, internal = false) {
    const fullName = `sumneko-lua.${name}`;
    const cmd = factory(this);
    const d = commands.registerCommand(fullName, cmd, null, internal);
    this.extCtx.subscriptions.push(d);
  }

  get subscriptions(): Disposable[] {
    return this.extCtx.subscriptions;
  }

  resolveBin(): [string, string[]] | undefined {
    // TODO: handle Lua.misc.executablePath
    const serverDir = this.config.serverDir
      ? this.config.serverDir
      : path.join(this.extCtx.storagePath, 'sumneko-lua-ls', 'extension', 'server');

    const platform = process.platform;
    const bin = path.join(serverDir, 'bin', platform === 'win32' ? 'lua-language-server.exe' : 'lua-language-server');
    if (!fs.existsSync(bin)) {
      return;
    }

    if (!executable.sync(bin)) {
      window.showInformationMessage(`${bin} is not executable`, 'error');
      return;
    }

    const args: string[] = ['-E', path.join(serverDir, 'bin', 'main.lua'), `--locale=${this.config.locale}`].concat(
      workspace.getConfiguration('Lua').get<string[]>('misc.parameters')!
    );
    if (this.config.logPath.length > 0) {
      args.push(`--logpath=${this.config.logPath}`);
    }

    return [bin, args];
  }

  async getCurrentVersion(): Promise<string | undefined> {
    if (this.config.serverDir) {
      const bin = this.resolveBin();
      if (!bin) return;
      const [cmd, args] = bin;
      args.push('--version');
      try {
        return String(execSync(`${cmd} ${args.join(' ')}`)).trim();
      } catch (err) {
        console.log(err);
        return;
      }
    } else {
      // must be based on the version of vscode extension
      try {
        const packageJson = path.join(this.extCtx.storagePath, 'sumneko-lua-ls', 'extension', 'package.json');
        const packageData = await fs.readJson(packageJson);
        return packageData.version;
      } catch (err) {
        console.error(err);
        return;
      }
    }
  }

  async checkUpdate() {
    // no need
    if (this.config.serverDir) return;

    const currentVersion = await this.getCurrentVersion();
    if (!currentVersion) return;

    const latest = await getLatestRelease();
    if (!latest) {
      return;
    }
    const latestVersion = latest.version.match(/\d.*/);
    if (!latestVersion) {
      return;
    }

    if (versionCompare(latestVersion[0], currentVersion) <= 0) {
      return;
    }

    const msg = `Sumneko lua-language-server has a new release: ${latest.version}, you're using v${currentVersion}.`;
    if (this.config.prompt) {
      const ret = await window.showQuickpick(['Download the latest server', 'Cancel'], msg);
      if (ret === 0) {
        await this.client.stop();
        try {
          await downloadServer(this.extCtx, latest);
        } catch (e) {
          console.error(e);
          window.showInformationMessage('Upgrade server failed', 'error');
          return;
        }
        this.client.start();
      } else {
        window.showInformationMessage(`You can run ':CocCommand sumneko-lua.install' to upgrade server manually`);
      }
    } else {
      window.showInformationMessage(`${msg} Run :CocCommand sumneko-lua.install to upgrade`);
    }
  }

  createClient(): undefined | LanguageClient {
    const bin = this.resolveBin();
    if (!bin) return;

    const [command, args] = bin;

    const serverOptions: ServerOptions = { command, args };

    const clientOptions: LanguageClientOptions = {
      documentSelector: [{ language: 'lua' }],
      progressOnInitialization: true,
      initializationOptions: {
        changeConfiguration: true,
      },
      middleware: {
        workspace: {
          configuration: async (params, token, next) => {
            const result = await next(params, token);

            if (!this.config.nvimLuaDev || !Array.isArray(result)) {
              return result;
            }

            const sectionIndex = params.items.findIndex((item) => {
              if (item.section == 'Lua') {
                return true;
              }
            });

            if (sectionIndex == -1) {
              return result;
            }

            const configuration = result[sectionIndex];

            const library = configuration.workspace.library || [];

            const runtime = await workspace.nvim.call('expand', ['$VIMRUNTIME/lua']);
            if (!library.includes(runtime)) {
              library.push(runtime);
            }

            const types = await this.neodev.getTypesPath();
            if (types && !library.includes(types)) {
              library.push(types);
            }

            configuration.workspace.library = library;

            result[sectionIndex] = configuration;

            return result;
          },
        },
      },
    };
    return new LanguageClient('sumneko-lua', 'Sumneko Lua Language Server', serverOptions, clientOptions);
  }

  async startServer() {
    const client = this.createClient();
    if (!client) return;
    this.extCtx.subscriptions.push(services.registLanguageClient(client));
    await client.onReady();
    this.client = client;
    // activate components
    this.activateCommand();
    this.activateStatusBar();
  }

  activateStatusBar() {
    // window status bar
    const bar = window.createStatusBarItem();
    this.extCtx.subscriptions.push(bar);

    let keepHide = false;

    this.client.onNotification('$/status/show', () => {
      keepHide = false;
      bar.show();
    });
    this.client.onNotification('$/status/hide', () => {
      keepHide = true;
      bar.hide();
    });
    this.client.onNotification('$/status/report', (params) => {
      const text: string = params.text;
      bar.isProgress = text.includes('$(loading~spin)');
      bar.text = text.replace('$(loading~spin)', '');
      this.barTooltip = params.tooltip;
    });

    events.on(
      'BufEnter',
      async () => {
        const doc = await workspace.document;
        if (isLuaDocument(doc.textDocument)) {
          if (!keepHide) bar.show();
        } else {
          bar.hide();
        }
      },
      null,
      this.extCtx.subscriptions
    );
  }

  activateCommand() {
    this.client.onNotification('$/command', (params) => {
      if (params.command != 'lua.config') {
        return;
      }
      const propMap: Map<string, Map<string, any>> = new Map();
      for (const data of params.data) {
        const folder = workspace.getWorkspaceFolder(data.uri);
        const config = workspace.getConfiguration(undefined, folder ? data.uri : undefined);
        if (data.action == 'add') {
          let value = config.get<any[]>(data.key, []);
          // weird...
          value = Array.from(value);
          value.push(data.value);
          config.update(data.key, value, data.global);
          continue;
        }
        if (data.action == 'set') {
          config.update(data.key, data.value, data.global);
          continue;
        }
        if (data.action == 'prop') {
          if (!propMap[data.key]) {
            propMap[data.key] = config.get(data.key);
          }
          propMap[data.key][data.prop] = data.value;
          config.update(data.key, propMap[data.key], data.global);
          continue;
        }
      }
    });
  }
}
