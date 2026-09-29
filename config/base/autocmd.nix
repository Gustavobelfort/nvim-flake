{
  autoCmd = [
    {
      desc = "Jump to the position of the last edit when reopening a file";
      event = "BufReadPost";
      callback.__raw = ''
        function(args)
          local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
          local lines = vim.api.nvim_buf_line_count(args.buf)
          if mark[1] > 1 and mark[1] <= lines then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end
      '';
    }
  ];
}
