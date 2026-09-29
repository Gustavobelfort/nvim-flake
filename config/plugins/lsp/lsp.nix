{
  # Default server configurations (cmd, filetypes, root markers) come from
  # nvim-lspconfig; `lsp.servers` enables them through Neovim's native
  # vim.lsp.config / vim.lsp.enable.
  plugins.lspconfig.enable = true;

  lsp = {
    servers = {
      # Advertise nvim-cmp's completion capabilities to every server. The old
      # config computed these and then overwrote them on the next line.
      "*".config.capabilities.__raw = ''
        vim.tbl_deep_extend(
          "force",
          vim.lsp.protocol.make_client_capabilities(),
          require("cmp_nvim_lsp").default_capabilities(),
          { textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } } }
        )
      '';

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
      -- Show the current line's diagnostics in a float when the cursor rests.
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "line",
          })
        end,
      })

      if client.name == "rust_analyzer" then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    '';
  };

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
