{
  plugins.toggleterm = {
    enable = true;
    settings = {
      size = ''
        function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end
      '';
      open_mapping = "[[<C-\\>]]";
      hide_numbers = true;
      shade_terminals = true;
      start_in_insert = true;
      terminal_mappings = true;
      persist_mode = true;
      insert_mappings = true;
      close_on_exit = true;
      direction = "horizontal"; # 'vertical' | 'horizontal' | 'tab' | 'float'
      auto_scroll = true;
      float_opts = {
        border = "single";
        width = 80;
        height = 20;
        winblend = 0;
      };
      winbar = {
        enabled = true;
        name_formatter = "function(term) return term.name end";
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<Leader>r";
      action.__raw = ''
        function()
          local run = { go = "go run", rust = "cargo run", haskell = "runhaskell" }
          local cmd = run[vim.bo.filetype]
          if cmd then
            vim.cmd("TermExec cmd='clear; echo \"Running current file...\"; " .. cmd .. " %'")
          end
        end
      '';
      options = {
        silent = true;
        desc = "Run current file";
      };
    }
  ];

  autoCmd = [
    {
      desc = "Terminal-mode keymaps for toggleterm buffers";
      event = "TermOpen";
      pattern = "term://*toggleterm#*";
      callback.__raw = ''
        function()
          local opts = { buffer = 0 }
          vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
          vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
          vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
          vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
          vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
        end
      '';
    }
  ];
}
