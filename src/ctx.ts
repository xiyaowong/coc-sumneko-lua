import {
  commands,
  Disposable,
  ExtensionContext,
  LanguageClient,
  LanguageClientOptions,
  ServerOptions,
  services,
  window,
} from 'coc.nvim';
import executable from 'executable';
import * as fs from 'fs-extra';
import versionCompare from 'node-version-compare';
import path from 'path';
import { Config } from './config';
import { downloadServer, getLatestRelease } from './downloader';

export type Cmd = (...args: any[]) => unknown;

export class Ctx {
  client!: LanguageClient;
  public readonly config = new Config();

  constructor(public readonly extCtx: ExtensionContext) {}

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
    const platform = process.platform;
    const serverDir = path.join(this.extCtx.storagePath, 'sumneko-lua-ls', 'extension', 'server');
    const bin = path.join(
      serverDir,
      'bin',
      platform === 'win32' ? 'Windows' : platform === 'darwin' ? 'macOS' : 'Linux',
      platform === 'win32' ? 'lua-language-server.exe' : 'lua-language-server'
    );
    console.log(bin);
    if (!fs.existsSync(bin)) {
      return;
    }

    if (!executable.sync(bin)) {
      window.showMessage(`${bin} is not executable`, 'error');
      return;
    }

    return [bin, ['-E', path.join(serverDir, 'main.lua'), `--locale=${this.config.locale}`]];
  }

  async checkUpdate() {
    const latest = await getLatestRelease();
    if (!latest) {
      return;
    }

    let old = '';
    try {
      const packageJson = path.join(this.extCtx.storagePath, 'sumneko-lua-ls', 'extension', 'package.json');
      const packageData = await fs.readJson(packageJson);
      old = packageData.version;
    } catch (err) {
      console.error(err);
      return;
    }

    const latestV = latest.tag.match(/\d.*/);
    if (!latestV) {
      return;
    }

    if (versionCompare(latestV[0], old) <= 0) {
      return;
    }

    const msg = `Sumneko lua-language-server has a new release: ${latest.tag}, you're using v${old}.`;
    if (this.config.prompt) {
      const ret = await window.showQuickpick(['Download the latest server', 'Cancel'], msg);
      if (ret === 0) {
        if (process.platform === 'win32') {
          await this.client.stop();
        }
        try {
          await downloadServer(this.extCtx, latest);
        } catch (e) {
          console.error(e);
          window.showMessage('Upgrade server failed', 'error');
          return;
        }
        await this.client.stop();
        this.client.start();
      } else {
        window.showMessage(`You can run ':CocCommand sumneko-lua.install' to upgrade server manually`);
      }
    } else {
      window.showMessage(`${msg} Run :CocCommand sumneko-lua.install to upgrade`);
    }
  }

  async startServer() {
    const bin = this.resolveBin();
    if (!bin) {
      return;
    }

    const [command, args] = bin;
    const serverOptions: ServerOptions = { command, args };
    const clientOptions: LanguageClientOptions = {
      documentSelector: [{ language: 'lua' }],
    };
    const client = new LanguageClient('sumneko-lua', 'Sumneko Lua Language Server', serverOptions, clientOptions);

    this.extCtx.subscriptions.push(services.registLanguageClient(client));
    this.client = client;
  }
}
