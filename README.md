# nvim-flake

Neovim configured with [Nixvim](https://github.com/nix-community/nixvim).

```sh
nix run github:Gustavobelfort/nvim-flake       # try it
nix flake check                                 # build it and start it headless
```

## Outputs

- `packages.<system>.default`: the wrapped `nvim`, with every language server
  and formatter it uses on its own `PATH`.
- `nixvimModules.default`: the raw module, for `makeNixvimWithModule`.

A consumer can adjust the package without forking it, because Nixvim packages
have an `extend` function. This is how a system flake points nixd at its own
nixpkgs and options:

```nix
inputs.nvim-flake.packages.${system}.default.extend {
  lsp.servers.nixd.config.settings.nixd = {
    nixpkgs.expr = "import ${inputs.nixpkgs} { }";
    options.nixos.expr = ''(builtins.getFlake "/path/to/flake").nixosConfigurations.host.options'';
  };
}
```

## Layout

`config/base` holds options, keymaps and autocommands; `config/plugins` has one
file per plugin, grouped by purpose. Leader is Space.
