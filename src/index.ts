import { ExtensionContext, window } from 'coc.nvim';
import { existsSync, mkdirSync } from 'fs';
import * as cmds from './commands';
import { Ctx } from './ctx';
import { downloadServer } from './downloader';

export async function activate(context: ExtensionContext): Promise<void> {
  const ctx = new Ctx(context);
  if (!ctx.config.enabled) {
    return;
  }

  const serverRoot = context.storagePath;
  if (!existsSync(serverRoot)) {
    mkdirSync(serverRoot);
  }

  ctx.registerCommand('install', cmds.install);

  const bin = ctx.resolveBin();
  if (!bin) {
    let ret = 0;
    if (ctx.config.prompt) {
      ret = await window.showQuickpick(['Yes', 'Cancel'], 'Sumneko lua language server if not found, install now?');
    }
    if (ret === 0) {
      try {
        await downloadServer(context);
      } catch (e) {
        console.error(e);
        window.showMessage('Download Sumneko lua language server failed', 'error');
        return;
      }
    } else {
      window.showMessage(`You can run ':CocCommand sumneko-lua.install' to install server manually`);
      return;
    }
  }

  ctx.registerCommand('version', cmds.version);
  ctx.registerCommand('restart', (ctx) => {
    return async () => {
      window.showMessage(`Reloading sumneko lua-language-server...`);

      for (const sub of ctx.subscriptions) {
        try {
          sub.dispose();
        } catch (e) {
          console.error(e);
        }
      }

      await activate(context);

      window.showMessage(`Reloaded sumneko lua-language-server`);
    };
  });

  await ctx.startServer();
  await ctx.checkUpdate();
}
