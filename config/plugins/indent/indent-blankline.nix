let
  # Catppuccin defines these for rainbow-delimiters, so the indent scope and the
  # brackets share colours without hardcoding a palette. The previous hex values
  # were One Dark's.
  rainbow = [
    "RainbowDelimiterRed"
    "RainbowDelimiterYellow"
    "RainbowDelimiterBlue"
    "RainbowDelimiterOrange"
    "RainbowDelimiterGreen"
    "RainbowDelimiterViolet"
    "RainbowDelimiterCyan"
  ];
in
{
  plugins.indent-blankline = {
    enable = true;
    settings.scope.highlight = rainbow;
    luaConfig.post = ''
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    '';
  };

  plugins.rainbow-delimiters.settings.highlight = rainbow;
}
