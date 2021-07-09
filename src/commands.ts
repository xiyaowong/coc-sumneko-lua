import { window } from 'coc.nvim';
import path from 'path';
import { Cmd, Ctx } from './ctx';
import { downloadServer } from './downloader';
import { readJson } from 'fs-extra';

export function install(ctx: Ctx): Cmd {
  return async () => {
    await downloadServer(ctx.extCtx);
    if (ctx.client && ctx.client.needsStop()) {
      await ctx.client.stop();
      ctx.client.start();
    } else {
      window.showMessage('May be you should restart the server');
    }
  };
}

export function version(ctx: Ctx): Cmd {
  return async () => {
    const packageJson = path.join(ctx.extCtx.storagePath, 'sumneko-lua-ls', 'extension', 'package.json');
    const packageData = await readJson(packageJson);
    window.showMessage(packageData.version);
  };
}
