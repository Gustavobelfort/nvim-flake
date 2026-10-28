let
  move = key: fn: query: desc: {
    mode = [
      "n"
      "x"
      "o"
    ];
    inherit key;
    action.__raw = ''function() require("nvim-treesitter-textobjects.move").${fn}("${query}", "textobjects") end'';
    options = {
      silent = true;
      inherit desc;
    };
  };
in
{
  # All grammars come prebuilt from Nix (the module's default), so nothing is
  # compiled or downloaded at runtime.
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;
    folding.enable = true;
  };

  # Supplies the @function/@class queries mini.ai's F and c textobjects use, as
  # well as the moves below.
  plugins.treesitter-textobjects.enable = true;

  # Keeps the enclosing function or block signature pinned at the top.
  plugins.treesitter-context = {
    enable = true;
    settings.max_lines = 3;
  };

  keymaps = [
    (move "]f" "goto_next_start" "@function.outer" "Next function")
    (move "[f" "goto_previous_start" "@function.outer" "Previous function")
    (move "]c" "goto_next_start" "@class.outer" "Next class")
    (move "[c" "goto_previous_start" "@class.outer" "Previous class")
    (move "]a" "goto_next_start" "@parameter.inner" "Next argument")
    (move "[a" "goto_previous_start" "@parameter.inner" "Previous argument")
  ];

  extraConfigLuaPost = ''
    Snacks.toggle({
      name = "Treesitter context",
      get = function() return require("treesitter-context").enabled() end,
      set = function(state) require("treesitter-context")[state and "enable" or "disable"]() end,
    }):map("<Leader>ut")
  '';
}
