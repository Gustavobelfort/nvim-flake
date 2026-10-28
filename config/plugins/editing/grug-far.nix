# Project-wide search and replace with ripgrep; replaces Spectre.
{
  plugins.grug-far.enable = true;
  dependencies.ripgrep.enable = true;

  keymaps = [
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Leader>sr";
      action.__raw = ''
        function()
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          require("grug-far").open({
            transient = true,
            prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil },
          })
        end
      '';
      options = {
        silent = true;
        desc = "Search and replace";
      };
    }
  ];
}
