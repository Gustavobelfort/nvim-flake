let
  flash = mode: key: fn: desc: {
    inherit mode key;
    action.__raw = "function() require('flash').${fn}() end";
    options = {
      silent = true;
      inherit desc;
    };
  };
in
{
  plugins.flash = {
    enable = true;
    settings = {
      labels = "asdfghjklqwertyuiopzxcvbnm";
      search.mode = "fuzzy";
      jump.autojump = true;
      label.rainbow = {
        enabled = true;
        shade = 5;
      };
    };
  };

  keymaps = [
    (flash [ "n" "x" "o" ] "<C-f>" "jump" "Flash jump")
    (flash [ "n" "x" "o" ] "<Leader>t" "treesitter" "Flash treesitter select")
    (flash "o" "<Leader>r" "remote" "Flash remote")
    (flash [ "x" "o" ] "<Leader>T" "treesitter_search" "Flash treesitter search")
  ];
}
