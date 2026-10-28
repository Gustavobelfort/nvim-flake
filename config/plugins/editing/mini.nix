{
  plugins.mini = {
    enable = true;
    # Icons for snacks, bufferline, lualine, trouble and oil; the shim makes
    # plugins that still ask for nvim-web-devicons get mini.icons instead.
    mockDevIcons = true;
    modules = {
      icons = { };
      # Smarter a/i textobjects: arguments (a), function calls (f), quotes (q),
      # brackets (b), and treesitter functions (F) and classes (c).
      ai.custom_textobjects = {
        F.__raw = ''require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })'';
        c.__raw = ''require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })'';
      };
      # Under g, because s is the split prefix: gsa add, gsd delete, gsr replace.
      surround.mappings = {
        add = "gsa";
        delete = "gsd";
        find = "gsf";
        find_left = "gsF";
        highlight = "gsh";
        replace = "gsr";
        update_n_lines = "gsn";
      };
      pairs = { };
    };
  };

  # Neovim's built-in gc/gcc comments, with the commentstring picked from the
  # treesitter language under the cursor (JSX inside TSX, Lua inside Nix).
  plugins.ts-comments.enable = true;
}
