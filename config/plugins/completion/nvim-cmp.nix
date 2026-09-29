{
  imports = [ ./source.nix ];

  plugins.cmp = {
    enable = true;
    autoEnableSources = true;

    settings = {
      snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

      window = {
        completion.__raw = "cmp.config.window.bordered()";
        documentation.__raw = "cmp.config.window.bordered()";
      };

      formatting = {
        fields = [
          "kind"
          "abbr"
          "menu"
        ];
        # Icons from https://www.nerdfonts.com/cheat-sheet
        format = ''
          function(entry, vim_item)
            local icons = {
              Text = "󰊄", Method = "", Function = "󰡱", Constructor = "",
              Field = "", Variable = "󱀍", Class = "", Interface = "",
              Module = "󰕳", Property = "", Unit = "", Value = "",
              Enum = "", Keyword = "", Snippet = "", Color = "",
              File = "", Reference = "", Folder = "", EnumMember = "",
              Constant = "", Struct = "", Event = "", Operator = "",
              TypeParameter = "",
            }
            vim_item.kind = icons[vim_item.kind] or vim_item.kind
            vim_item.menu = ({
              path = "[Path]",
              nvim_lua = "[Lua]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
            })[entry.source.name]
            return vim_item
          end
        '';
      };

      sources = [
        { name = "path"; }
        { name = "nvim_lua"; }
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "buffer"; }
      ];

      mapping = {
        "<C-u>" = "cmp.mapping.scroll_docs(-4)";
        "<C-d>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = ''
          cmp.mapping(function(fallback)
            local luasnip = require("luasnip")
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" })
        '';
        "<S-Tab>" = ''
          cmp.mapping(function(fallback)
            local luasnip = require("luasnip")
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" })
        '';
      };
    };

    cmdline.":" = {
      mapping.__raw = "cmp.mapping.preset.cmdline()";
      # Paths first; commands only when no path matches.
      sources.__raw = "cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })";
    };
  };
}
