# Format on save. Replaces none-ls, whose beautysh, rustfmt and nixpkgs_fmt
# builtins have all been removed upstream.
{
  plugins.conform-nvim = {
    enable = true;
    # Puts every formatter named below on Neovim's PATH, so none has to be
    # installed globally.
    autoInstall.enable = true;

    settings = {
      formatters_by_ft =
        let
          prettier = [ "prettier" ];
        in
        {
          nix = [ "nixfmt" ];
          sh = [ "shfmt" ];
          bash = [ "shfmt" ];
          rust = [ "rustfmt" ];
          go = [ "gofmt" ];
          haskell = [ "fourmolu" ];
          javascript = prettier;
          javascriptreact = prettier;
          typescript = prettier;
          typescriptreact = prettier;
          css = prettier;
          html = prettier;
          json = prettier;
          yaml = prettier;
          markdown = prettier;
        };

      # Falls back to the language server when no formatter is listed.
      format_on_save = {
        timeout_ms = 1000;
        lsp_format = "fallback";
      };
    };
  };
}
