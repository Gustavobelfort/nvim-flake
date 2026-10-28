# blink.cmp replaces nvim-cmp and its six source plugins: LSP, path, snippet and
# buffer sources are built in, and it is noticeably faster on large buffers.
{
  plugins.blink-cmp = {
    enable = true;
    # Advertises blink's completion capabilities to every language server.
    setupLspCapabilities = true;
    settings = {
      # Tab/S-Tab cycle and jump through snippets, as the nvim-cmp config did.
      keymap = {
        preset = "super-tab";
        "<CR>" = [
          "accept"
          "fallback"
        ];
        "<C-u>" = [
          "scroll_documentation_up"
          "fallback"
        ];
        "<C-d>" = [
          "scroll_documentation_down"
          "fallback"
        ];
      };
      snippets.preset = "luasnip";
      sources.default = [
        "lsp"
        "path"
        "snippets"
        "buffer"
      ];
      completion = {
        documentation.auto_show = true;
        menu.border = "rounded";
        documentation.window.border = "rounded";
      };
      signature = {
        enabled = true;
        window.border = "rounded";
      };
      cmdline.enabled = true;
    };
  };

  plugins.luasnip = {
    enable = true;
    # Loads friendly-snippets' VSCode-format collection, which luasnip does not
    # do on its own.
    fromVscode = [ { } ];
  };
  plugins.friendly-snippets.enable = true;
}
