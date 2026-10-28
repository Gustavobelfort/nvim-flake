{
  plugins.neogit = {
    enable = true;
    # Opens diffs from the status buffer in diffview.
    settings.integrations.diffview = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<Leader>gn";
      action = "<cmd>Neogit<CR>";
      options = {
        silent = true;
        desc = "Neogit";
      };
    }
  ];
}
