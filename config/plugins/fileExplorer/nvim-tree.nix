{
  plugins.nvim-tree = {
    enable = true;
    settings = {
      disable_netrw = true;
      hijack_cursor = true;
      sort.sorter = "case_sensitive";
      view = {
        number = false;
        width = 25;
        side = "left";
      };
      renderer.group_empty = true;
      # Toggle with `H` inside the tree.
      filters.dotfiles = true;
      diagnostics.enable = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "tt";
      action = "<cmd>NvimTreeToggle<CR>";
      options = {
        silent = true;
        desc = "Toggle file tree";
      };
    }
  ];
}
