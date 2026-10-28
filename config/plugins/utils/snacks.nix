# snacks.nvim replaces telescope, toggleterm, nvim-notify, indent-blankline,
# undotree and nvim-tree's sidebar with one plugin and one config style. Its
# picker also backs the LSP navigation maps in lsp/lsp.nix.
let
  # Catppuccin defines these for rainbow-delimiters, so the indent scope and the
  # brackets share colours without hardcoding a palette.
  rainbow = [
    "RainbowDelimiterRed"
    "RainbowDelimiterYellow"
    "RainbowDelimiterBlue"
    "RainbowDelimiterOrange"
    "RainbowDelimiterGreen"
    "RainbowDelimiterViolet"
    "RainbowDelimiterCyan"
  ];

  snack = mode: key: lua: desc: {
    inherit mode key;
    action.__raw = "function() ${lua} end";
    options = {
      silent = true;
      inherit desc;
    };
  };
  n = snack "n";
  pick =
    key: picker: desc:
    n key "Snacks.picker.${picker}()" desc;
in
{
  plugins.snacks = {
    enable = true;
    settings = {
      # Turns off treesitter, LSP and the like in huge files, which otherwise
      # freeze the editor on open.
      bigfile.enabled = true;
      # Renders the file before plugins load when nvim is started on one.
      quickfile.enabled = true;
      dashboard.enabled = true;
      explorer.enabled = true;
      picker.enabled = true;
      input.enabled = true;
      notifier.enabled = true;
      scope.enabled = true;
      statuscolumn.enabled = true;
      # Highlights the LSP references of the word under the cursor; ]] and [[
      # jump between them.
      words.enabled = true;
      indent = {
        enabled = true;
        scope.hl = rainbow;
      };
      terminal.win.style = "terminal";
    };
  };

  plugins.rainbow-delimiters.settings.highlight = rainbow;

  # Snacks.lazygit shells out to it.
  dependencies.lazygit.enable = true;

  keymaps = [
    (pick "<Leader><Space>" "smart" "Find files (smart)")
    (pick "<Leader>/" "grep" "Grep")
    (n "<Leader>e" "Snacks.explorer()" "File explorer")

    # f: files
    (pick "<Leader>ff" "files" "Find files")
    (pick "<Leader>fr" "recent" "Recent files")
    (pick "<Leader>fb" "buffers" "Buffers")
    (pick "<Leader>fp" "projects" "Projects")
    (n "<Leader>fR" "Snacks.rename.rename_file()" "Rename file (LSP-aware)")

    # s: search
    (pick "<Leader>sg" "grep" "Grep")
    (snack [ "n" "x" ] "<Leader>sw" "Snacks.picker.grep_word()" "Grep word or selection")
    (pick "<Leader>sh" "help" "Help")
    (pick "<Leader>sk" "keymaps" "Keymaps")
    (pick "<Leader>sd" "diagnostics" "Diagnostics")
    (pick "<Leader>sD" "diagnostics_buffer" "Buffer diagnostics")
    (pick "<Leader>ss" "lsp_symbols" "LSP symbols")
    (pick "<Leader>sS" "lsp_workspace_symbols" "Workspace symbols")
    (pick "<Leader>su" "undo" "Undo history")
    (pick "<Leader>sm" "marks" "Marks")
    (pick "<Leader>sj" "jumps" "Jumplist")
    (pick "<Leader>sq" "qflist" "Quickfix list")
    (pick "<Leader>sR" "resume" "Resume last picker")
    (n "<Leader>st" "Snacks.picker.todo_comments()" "Todo comments")
    (pick "<Leader>s?" "pickers" "All pickers")
    (pick "<Leader>:" "command_history" "Command history")
    (pick "<Leader>n" "notifications" "Notification history")

    # g: git
    (n "<Leader>gg" "Snacks.lazygit()" "Lazygit")
    (pick "<Leader>gs" "git_status" "Git status")
    (pick "<Leader>gl" "git_log" "Git log")
    (pick "<Leader>gL" "git_log_file" "Git log (file)")
    (snack [ "n" "x" ] "<Leader>gB" "Snacks.gitbrowse()" "Open in browser")

    # b: buffers
    (n "<Leader>bd" "Snacks.bufdelete()" "Delete buffer")
    (n "<Leader>bo" "Snacks.bufdelete.other()" "Delete other buffers")

    (n "<Leader>uz" "Snacks.zen()" "Zen mode")
    (snack [ "n" "t" ] "]]" "Snacks.words.jump(vim.v.count1)" "Next reference")
    (snack [ "n" "t" ] "[[" "Snacks.words.jump(-vim.v.count1)" "Previous reference")

    # Terminal. <C-\> was toggleterm's; <A-d> was Lspsaga's floating one.
    (snack [ "n" "t" ] "<C-\\>" "Snacks.terminal()" "Toggle terminal")
    (snack [
      "n"
      "t"
    ] "<A-d>" "Snacks.terminal(nil, { win = { position = 'float' } })" "Floating terminal")
    (n "<Leader>cR" ''
      local run = { go = "go run", rust = "cargo run", haskell = "runhaskell" }
      local cmd = run[vim.bo.filetype]
      if cmd then
        Snacks.terminal(cmd .. " " .. vim.fn.shellescape(vim.fn.expand("%")), { auto_close = false })
      end
    '' "Run current file")
  ];

  # Toggles show their current state in which-key. Registered once snacks has
  # loaded, since Snacks.toggle is a runtime object.
  extraConfigLuaPost = ''
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<Leader>uw")
    Snacks.toggle.option("relativenumber", { name = "Relative number" }):map("<Leader>uL")
    Snacks.toggle.line_number():map("<Leader>ul")
    Snacks.toggle.diagnostics():map("<Leader>ud")
    Snacks.toggle.inlay_hints():map("<Leader>uh")
    Snacks.toggle.indent():map("<Leader>ug")
    Snacks.toggle.treesitter():map("<Leader>uT")
  '';

  autoCmd = [
    {
      desc = "Leave terminal mode and move between windows from a terminal";
      event = "TermOpen";
      callback.__raw = ''
        function()
          local opts = { buffer = 0 }
          vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
          vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
          vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
          vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        end
      '';
    }
  ];
}
