{
  plugins.diffview.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<Leader>gd";
      action = "<cmd>DiffviewOpen<CR>";
      options = {
        silent = true;
        desc = "Diff working tree";
      };
    }
    {
      mode = "n";
      key = "<Leader>gh";
      action = "<cmd>DiffviewFileHistory %<CR>";
      options = {
        silent = true;
        desc = "File history";
      };
    }
  ];
}
