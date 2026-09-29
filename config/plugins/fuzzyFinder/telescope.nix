{
  plugins.telescope = {
    enable = true;
    # Native sorter: much faster fuzzy matching on large repos.
    extensions.fzf-native.enable = true;

    keymaps = {
      "<Leader>e" = {
        action = "builtin";
        options.desc = "Telescope pickers";
      };
      "<Leader>ff" = {
        action = "find_files";
        options.desc = "Find files";
      };
      "<Leader>fg" = {
        action = "live_grep";
        options.desc = "Live grep";
      };
      "<Leader>fb" = {
        action = "buffers";
        options.desc = "Buffers";
      };
      "<Leader>fr" = {
        action = "oldfiles";
        options.desc = "Recent files";
      };
      "<Leader>fh" = {
        action = "help_tags";
        options.desc = "Help";
      };
      "<Leader>fd" = {
        action = "diagnostics";
        options.desc = "Diagnostics";
      };
    };
  };

  # Telescope's live_grep and find_files shell out to these.
  dependencies = {
    ripgrep.enable = true;
    fd.enable = true;
  };
}
