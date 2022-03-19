import { ExtensionContext, window } from 'coc.nvim';
import { writeFile, existsSync, mkdirSync, readFile } from 'fs-extra';
import path from 'path';
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
    let ret = 'Yes';
    if (ctx.config.prompt) {
      ret =
        (await window.showInformationMessage(
          'Sumneko lua language server is not found, install now?',
          'Yes',
          'Cancel'
        )) || 'Yes';
    }
    if (ret == 'Yes') {
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
  ctx.registerCommand('showTooltip', cmds.showTooltip);
  ctx.registerCommand('insertNvimLuaPluginLibrary', cmds.insertNvimLuaPluginLibrary);
  ctx.registerCommand('checkUpdate', () => async () => await ctx.checkUpdate());

  await ctx.startServer();
  if (ctx.config.checkUpdate) {
    const dataPath = path.join(context.storagePath, 'checkUpdate');
    let lastCheck = 0;
    if (existsSync(dataPath)) {
      lastCheck = Number((await readFile(dataPath)).toString());
    }
    const now = Date.now();
    if (now - lastCheck > 4 * 60 * 60 * 1000) {
      await ctx.checkUpdate();
      await writeFile(dataPath, now.toString());
    }
  }
}
