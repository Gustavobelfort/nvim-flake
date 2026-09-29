{
  plugins.spectre.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<C-s>";
      action.__raw = "function() require('spectre').toggle() end";
      options = {
        silent = true;
        desc = "Search and replace (Spectre)";
      };
    }
  ];
}
