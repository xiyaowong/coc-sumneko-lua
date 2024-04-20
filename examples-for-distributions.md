# Config Examples for Distributions

## NixOS

`coc-sumneko-lua` (or `lua-language-server`) use `sumneko-lua.serverDir` to store generated metafiles and log. However, `lua-language-server` installed by nix is read-only in NixOS. Therefore just setting `sumneko-lua.serverDir` is not enough in NixOS, some cmd args are also needed to be set.

Here's an minimal working example:

`coc-settings.json`:

```json
{
  "Lua.misc.parameters": [
    "--metapath",
    "~/.cache/sumneko_lua/meta",
    "--logpath",
    "~/.cache/sumneko_lua/log"
  ],
  "sumneko-lua.serverDir": "${pkgs.lua-language-server}/share/lua-language-server"
}
```

`${pkgs.lua-language-server}` needs to be replaced by real path of `lua-language-server`. And `lua-language-server` used to be called `sumneko-lua-language-server` in `nixpkgs`, maybe you need to use old name.

If you don't want to generate your coc configuration by nix and don't want to change the absolute path of `lua-language-server` every time updating your `nixpkgs`, you can link `lua-language-server` to somewhere fixed and change last line of configuration to the link target.

For example, add it to `environment.systemPackages` and change

- `configuration.nix`

  ```
  { pkgs, ... }: {
    environment.systemPackages = [ pkgs.lua-language-server ];
  }
  ```

- `coc-settings.json`

  ```json
  {
    "Lua.misc.parameters": [
      "--metapath",
      "~/.cache/sumneko_lua/meta",
      "--logpath",
      "~/.cache/sumneko_lua/log"
    ],
    "sumneko-lua.serverDir": "/run/current-system/sw/share/lua-language-server"
  }
  ```

## Others

Default config should work.
