# coc-sumneko-lua

Lua extension using sumneko lua-language-server for coc.nvim

This extension uses server binaries extracted from [`sumneko/vscode-lua`](https://github.com/sumneko/vscode-lua)

## Features

- Supported features by the server

  ![base](https://user-images.githubusercontent.com/47070852/133086083-a5357ca3-ada6-46d9-953f-f86026c137e4.png)

- Nvim lua development(check setting `sumneko-lua.enableNvimLuaDev`). Credit: [folke/lua-dev.nvim](https://github.com/folke/lua-dev.nvim)

  ![nvim-lua-dev](https://user-images.githubusercontent.com/47070852/133085674-2310670d-6129-4aac-86ea-0e475bf09b25.gif)

- Inlay-hints(check settings `sumneko-lua.inlayHints.*`, `Lua.hint.*`). Highlights: `CocLuaTypeHint`, `CocLuaParamHint`

  ![inlay-hint](https://user-images.githubusercontent.com/47070852/154476119-ce01b090-6ae4-42dd-887a-52d14fd5d037.png)

## Install

`:CocInstall coc-sumneko-lua`

## [Settings(Click me)](https://github.com/xiyaowong/coc-sumneko-lua/blob/main/settings.md)

## Commands

| Command                                  | Description                                         |
| ---------------------------------------- | --------------------------------------------------- |
| `sumneko-lua.install`                    | Install or update sumneko lua-language-server       |
| `sumneko-lua.restart`                    | Restart server                                      |
| `sumneko-lua.version`                    | Echo server version                                 |
| `sumneko-lua.showTooltip`                | Show tooltips                                       |
| `sumneko-lua.insertNvimLuaPluginLibrary` | Insert nvim lua plugin to current workspace library |

## Credit

- [`fannheyward/coc-rust-analyzer`](https://github.com/fannheyward/coc-rust-analyzer)
- [`sumneko/vscode-lua`](https://github.com/sumneko/vscode-lua)
- [`josa42/coc-lua`](https://github.com/josa42/coc-lua)

## License

MIT

---

> This extension is built with [create-coc-extension](https://github.com/fannheyward/create-coc-extension)
