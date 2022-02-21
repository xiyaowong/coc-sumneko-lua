import { window, workspace } from 'coc.nvim';
import path from 'path';
import { Cmd, Ctx } from './ctx';
import { downloadServer } from './downloader';
import { readJson, existsSync } from 'fs-extra';

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

export function showTooltip(ctx: Ctx): Cmd {
  return async () => {
    window.showNotification({ content: ctx.barTooltip, timeout: 5000 });
  };
}

export function insertNvimLuaPluginLibrary(_: Ctx): Cmd {
  return async () => {
    const config = workspace.getConfiguration('Lua.workspace');
    const library = Array.from(config.get<string[]>('library') || []);

    const runtimepath = (await workspace.nvim.getOption('runtimepath')) as string;
    const paths = runtimepath
      .split(',')
      .map((v) => {
        return path.join(v, 'lua');
      })
      .filter((v) => !library.includes(v) && existsSync(v));

    if (!paths.length) return;

    const vimruntime = (await workspace.nvim.call('expand', ['$VIMRUNTIME/lua'])) as string;
    const myvimrc = path.join(path.dirname(await workspace.nvim.call('expand', ['$MYVIMRC'])), 'lua');

    const idx = await window.showQuickpick(
      paths.map((v, i) => {
        let name = '';

        if (v == vimruntime) {
          name = `${vimruntime} (auto added if sumneko-lua.enableNvimLuaDev is true )`;
        } else if (v == myvimrc) {
          name = `${myvimrc} (not recommended)`;
        } else {
          name = path.basename(path.dirname(v));
        }

        return i < 9 ? ` ${name}` : name;
      })
    );
    if (idx != -1) {
      library.push(paths[idx]);
      config.update('library', library);
    }
  };
}
