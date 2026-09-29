{
  opts = {
    mouse = "a";
    undofile = true;
    swapfile = true;
    ignorecase = true;
    smartcase = true;
    showmode = false; # lualine shows the mode
    showtabline = 2;
    smartindent = true;
    autoindent = true;
    expandtab = true;
    shiftwidth = 4;
    tabstop = 4;
    cmdheight = 1;
    cursorline = false;
    cursorcolumn = false;
    number = true;
    numberwidth = 4;
    relativenumber = true;
    # Always reserve the sign column, so gitsigns and diagnostics appearing do
    # not shift the text sideways.
    signcolumn = "yes";
    wrap = true;
    scrolloff = 8;
    termguicolors = true;
    # latin1 rather than the upstream gbk: it is the fallback that matches
    # Portuguese text files that are not UTF-8.
    fileencodings = "utf-8,latin1";
    # Also how soon CursorHold fires, which opens the diagnostic float.
    updatetime = 50;
    # Folds are computed by treesitter but start fully open.
    foldenable = false;
    foldlevel = 99;
    list = true;
    listchars = "tab:▸ ";
  };
}
