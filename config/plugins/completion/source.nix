{
  plugins = {
    cmp-buffer.enable = true;
    cmp-cmdline.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lua.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;

    luasnip = {
      enable = true;
      # Loads friendly-snippets' VSCode-format collection, which luasnip does
      # not do on its own.
      fromVscode = [ { } ];
    };
    friendly-snippets.enable = true;
  };
}
