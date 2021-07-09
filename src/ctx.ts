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
import { existsSync } from 'fs';
import { join } from 'path';
import { Config } from './config';

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
    const serverDir = join(this.extCtx.storagePath, 'sumneko-lua-ls', 'extension', 'server');
    const bin = join(
      serverDir,
      'bin',
      platform === 'win32' ? 'Windows' : platform === 'darwin' ? 'macOS' : 'Linux',
      platform === 'win32' ? 'lua-language-server.exe' : 'lua-language-server'
    );
    console.log(bin);
    if (!existsSync(bin)) {
      return;
    }

    if (!executable.sync(bin)) {
      window.showMessage(`${bin} is not executable`, 'error');
      return;
    }

    return [bin, ['-E', join(serverDir, 'main.lua'), `--locale=${this.config.locale}`]];
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
