# coc-sumneko-lua

Lua extension using sumneko lua-language-server for coc.nvim

This extension uses server binaries extracted from [`sumneko/vscode-lua`](https://github.com/sumneko/vscode-lua).
You can also custom the server path([`sumneko-lua.serverDir`](https://github.com/xiyaowong/coc-sumneko-lua/blob/main/settings.md#sumneko-luaserverdir)).

## Features

- Supported features by the server

  ![base](https://user-images.githubusercontent.com/47070852/133086083-a5357ca3-ada6-46d9-953f-f86026c137e4.png)

- Nvim lua development(check setting `sumneko-lua.enableNvimLuaDev`). Credit: [folke/neodev.nvim](https://github.com/folke/neodev.nvim)

  ![nvim-lua-dev](https://user-images.githubusercontent.com/47070852/133085674-2310670d-6129-4aac-86ea-0e475bf09b25.gif)

- Inlay-hints provided by coc.nvim.

## Install

`:CocInstall coc-sumneko-lua`

## [Settings (Click me)](settings.md)

## [Config Examples for Distributions (Currently only NixOS)](examples-for-distributions.md)

## Commands

| Command                                  | Description                                                                    |
| ---------------------------------------- | ------------------------------------------------------------------------------ |
| `sumneko-lua.install`                    | Install or update sumneko lua-language-server                                  |
| `sumneko-lua.restart`                    | Restart server                                                                 |
| `sumneko-lua.version`                    | Echo server version                                                            |
| `sumneko-lua.checkUpdate`                | Check update                                                                   |
| `sumneko-lua.showTooltip`                | Show tooltips                                                                  |
| `sumneko-lua.insertNvimLuaPluginLibrary` | Insert nvim lua plugin to current workspace library                            |
| `sumneko-lua.downloadNvimLuaTypes`       | **Download/Update** nvim lua types(Clone https://github.com/folke/neodev.nvim) |

## Credit

- [`fannheyward/coc-rust-analyzer`](https://github.com/fannheyward/coc-rust-analyzer)
- [`sumneko/vscode-lua`](https://github.com/sumneko/vscode-lua)
- [`josa42/coc-lua`](https://github.com/josa42/coc-lua)

## License

MIT

---

> This extension is built with [create-coc-extension](https://github.com/fannheyward/create-coc-extension)
