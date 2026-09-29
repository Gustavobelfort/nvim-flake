{
  plugins.lspsaga = {
    enable = true;
    settings = {
      ui.border = "single";
      outline = {
        auto_close = true;
        auto_preview = true;
        win_width = 25;
        win_position = "right";
      };
      code_action = {
        extend_gitsigns = true;
        show_server_name = true;
      };
      definition = {
        height = 0.5;
        width = 0.6;
      };
      scroll_preview = {
        scroll_down = "<C-f>";
        scroll_up = "<C-b>";
      };
    };
  };

  # Registered on LspAttach, per buffer. As global maps these lost to the
  # buffer-local defaults Neovim installs when a server attaches — `K` in
  # particular always opened the built-in hover, never Lspsaga's.
  lsp.keymaps =
    let
      saga = key: cmd: desc: {
        mode = "n";
        inherit key;
        action = "<cmd>Lspsaga ${cmd}<CR>";
        options = {
          silent = true;
          inherit desc;
        };
      };
    in
    [
      (saga "gh" "finder" "Definition, references and implementations")
      (
        saga "<Leader>ca" "code_action" "Code action"
        // {
          mode = [
            "n"
            "x"
          ];
        }
      )
      (saga "gr" "rename" "Rename")
      # Was a second `gr`, which silently replaced the one above.
      (saga "gR" "rename ++project" "Rename across the project")
      (saga "gD" "peek_definition" "Peek definition")
      (saga "gd" "goto_definition" "Go to definition")
      (saga "<Leader>sl" "show_line_diagnostics" "Line diagnostics")
      (saga "<Leader>sc" "show_cursor_diagnostics" "Cursor diagnostics")
      (saga "<Leader>sb" "show_buf_diagnostics" "Buffer diagnostics")
      (saga "[e" "diagnostic_jump_prev" "Previous diagnostic")
      (saga "]e" "diagnostic_jump_next" "Next diagnostic")
      {
        mode = "n";
        key = "[E";
        action.__raw = ''
          function()
            require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end
        '';
        options.desc = "Previous error";
      }
      {
        mode = "n";
        key = "]E";
        action.__raw = ''
          function()
            require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
          end
        '';
        options.desc = "Next error";
      }
      (saga "ss" "outline" "Toggle outline")
      (saga "K" "hover_doc ++keep" "Hover documentation")
      (saga "<Leader>ci" "incoming_calls" "Incoming calls")
      (saga "<Leader>co" "outgoing_calls" "Outgoing calls")
    ];

  # Not LSP-specific, so global.
  keymaps = [
    {
      mode = [
        "n"
        "t"
      ];
      key = "<A-d>";
      action = "<cmd>Lspsaga term_toggle<CR>";
      options = {
        silent = true;
        desc = "Floating terminal";
      };
    }
  ];
}
