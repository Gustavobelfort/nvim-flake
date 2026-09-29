{
  plugins.trouble.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "tr";
      # Trouble v3 replaced :TroubleToggle with per-mode subcommands.
      action = "<cmd>Trouble diagnostics toggle<CR>";
      options = {
        silent = true;
        desc = "Toggle Trouble diagnostics";
      };
    }
  ];
}
