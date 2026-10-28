{
  plugins.gitsigns.enable = true;

  keymaps =
    let
      gs = mode: key: lua: desc: {
        inherit mode key;
        action.__raw = "function() ${lua} end";
        options = {
          silent = true;
          inherit desc;
        };
      };
    in
    [
      (gs "n" "]h" "require('gitsigns').nav_hunk('next')" "Next hunk")
      (gs "n" "[h" "require('gitsigns').nav_hunk('prev')" "Previous hunk")
      (gs [ "n" "x" ] "<Leader>hs" "require('gitsigns').stage_hunk()" "Stage hunk")
      (gs [ "n" "x" ] "<Leader>hr" "require('gitsigns').reset_hunk()" "Reset hunk")
      (gs "n" "<Leader>hS" "require('gitsigns').stage_buffer()" "Stage buffer")
      (gs "n" "<Leader>hR" "require('gitsigns').reset_buffer()" "Reset buffer")
      (gs "n" "<Leader>hp" "require('gitsigns').preview_hunk_inline()" "Preview hunk")
      (gs "n" "<Leader>gb" "require('gitsigns').blame_line({ full = true })" "Blame line")
      (gs [ "o" "x" ] "ih" "require('gitsigns').select_hunk()" "Inside hunk")
    ];

  extraConfigLuaPost = ''
    Snacks.toggle({
      name = "Line blame",
      get = function() return require("gitsigns.config").config.current_line_blame end,
      set = function(state) require("gitsigns").toggle_current_line_blame(state) end,
    }):map("<Leader>ub")
  '';
}
