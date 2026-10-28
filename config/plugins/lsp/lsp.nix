{
  # Default server configurations (cmd, filetypes, root markers) come from
  # nvim-lspconfig; `lsp.servers` enables them through Neovim's native
  # vim.lsp.config / vim.lsp.enable.
  plugins.lspconfig.enable = true;

  lsp = {
    servers = {
      nixd = {
        enable = true;
        # Which nixpkgs and which option sets nixd completes against is the
        # consumer's business: a system flake extends this package with its own
        # `settings.nixd.nixpkgs` and `settings.nixd.options`.
        config.settings.nixd.formatting.command = [ "nixfmt" ];
      };

      gopls = {
        enable = true;
        config = {
          settings.gopls = {
            experimentalPostfixCompletions = true;
            analyses = {
              unusedparams = true;
              shadow = true;
            };
            staticcheck = true;
            usePlaceholders = true;
          };
        };
      };

      rust_analyzer.enable = true;
      bashls.enable = true;
      clangd.enable = true;
      pyright.enable = true;
      hls.enable = true;
      html.enable = true;
      cssls.enable = true;
      ts_ls.enable = true;
      dockerls.enable = true;
      jsonls.enable = true;
      yamlls.enable = true;
    };

    onAttach = ''
      if client.name == "rust_analyzer" then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    '';
  };

  # Registered on LspAttach, per buffer, so they win over the buffer-local
  # defaults Neovim installs when a server attaches. Navigation goes through the
  # snacks picker; everything else is the built-in vim.lsp.buf. Neovim's own
  # grn/gra/grr/gri defaults stay available too.
  lsp.keymaps =
    let
      map = mode: key: lua: desc: {
        inherit mode key;
        action.__raw = "function() ${lua} end";
        options = {
          silent = true;
          inherit desc;
        };
      };
      n = map "n";
    in
    [
      (n "gd" "Snacks.picker.lsp_definitions()" "Go to definition")
      (n "gD" "Snacks.picker.lsp_declarations()" "Go to declaration")
      (n "gr" "Snacks.picker.lsp_references()" "References")
      (n "gI" "Snacks.picker.lsp_implementations()" "Go to implementation")
      (n "gy" "Snacks.picker.lsp_type_definitions()" "Go to type definition")
      (n "<Leader>ci" "Snacks.picker.lsp_incoming_calls()" "Incoming calls")
      (n "<Leader>co" "Snacks.picker.lsp_outgoing_calls()" "Outgoing calls")
      (n "K" "vim.lsp.buf.hover({ border = 'rounded' })" "Hover documentation")
      (map "i" "<C-k>" "vim.lsp.buf.signature_help({ border = 'rounded' })" "Signature help")
      (map [ "n" "x" ] "<Leader>ca" "vim.lsp.buf.code_action()" "Code action")
      (n "<Leader>cr" "vim.lsp.buf.rename()" "Rename symbol")
      (n "<Leader>cl" "Snacks.picker.lsp_config()" "LSP info")
    ];

  keymaps = [
    {
      mode = "n";
      key = "<Leader>cd";
      action.__raw = "function() vim.diagnostic.open_float({ border = 'rounded' }) end";
      options = {
        silent = true;
        desc = "Line diagnostics";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Leader>cf";
      action.__raw = "function() require('conform').format({ lsp_format = 'fallback' }) end";
      options = {
        silent = true;
        desc = "Format";
      };
    }
  ];

  diagnostic.settings = {
    virtual_text = false;
    underline = true;
    # Replaces a pair of autocmds that hid diagnostics on every change and
    # re-showed them on InsertLeave: this is the built-in way to keep them from
    # updating while typing.
    update_in_insert = false;
    severity_sort = true;
    signs.text.__raw = ''
      {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      }
    '';
  };
}
