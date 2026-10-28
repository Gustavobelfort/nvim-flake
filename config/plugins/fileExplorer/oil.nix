# Directories as editable buffers: rename, move and delete files by editing
# lines and saving. The sidebar is snacks.explorer (<Leader>e).
{
  plugins.oil = {
    enable = true;
    settings = {
      default_file_explorer = true;
      delete_to_trash = true;
      skip_confirm_for_simple_edits = true;
      # Leaves the sign column free for oil-git-status.
      win_options.signcolumn = "yes:2";
      # g. toggles hidden files.
      view_options.show_hidden = false;
    };
  };
  plugins.oil-git-status.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "-";
      action = "<cmd>Oil<CR>";
      options = {
        silent = true;
        desc = "Open parent directory";
      };
    }
  ];
}
