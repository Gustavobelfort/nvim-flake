let
  map = mode: key: action: desc: {
    inherit mode key action;
    options = {
      silent = true;
    }
    // (if desc == null then { } else { inherit desc; });
  };
in
{
  globals.mapleader = " ";

  keymaps = [
    (map "" "<Space>" "<Nop>" null)
    (map "n" "S" "<cmd>w<CR>" "Save file")
    (map "n" "Q" "<cmd>qa<CR>" "Quit Neovim")
    (map "i" "jk" "<Esc>" "Exit insert mode")

    # Window navigation
    (map "n" "<C-h>" "<C-w>h" "Window left")
    (map "n" "<C-j>" "<C-w>j" "Window down")
    (map "n" "<C-k>" "<C-w>k" "Window up")
    (map "n" "<C-l>" "<C-w>l" "Window right")

    # Buffers
    (map "n" "<Tab>" "<cmd>bnext<CR>" "Next buffer")
    (map "n" "<S-Tab>" "<cmd>bprevious<CR>" "Previous buffer")

    # Visual-only ("x", not "v"): "v" also covers select mode, where typing a
    # capital J or K must replace the selection rather than move lines.
    (map "x" "<" "<gv" "Indent left and reselect")
    (map "x" ">" ">gv" "Indent right and reselect")
    (map "x" "J" ":move '>+1<CR>gv=gv" "Move selection down")
    (map "x" "K" ":move '<-2<CR>gv=gv" "Move selection up")

    # Splits. `s` is freed for them; `ss` is the Lspsaga outline.
    (map "" "s" "<Nop>" null)
    (map "n" "sl" "<cmd>set splitright<CR><cmd>vsplit<CR>" "Split right")
    (map "n" "sh" "<cmd>set nosplitright<CR><cmd>vsplit<CR>" "Split left")
    (map "n" "sk" "<cmd>set nosplitbelow<CR><cmd>split<CR>" "Split above")
    (map "n" "sj" "<cmd>set splitbelow<CR><cmd>split<CR>" "Split below")
    (map "n" "<C-=>" "<C-w>=" "Equalize windows")

    # Move windows
    (map "n" "<Leader>h" "<C-w>H" "Move window far left")
    (map "n" "<Leader>j" "<C-w>J" "Move window to bottom")
    (map "n" "<Leader>k" "<C-w>K" "Move window to top")
    (map "n" "<Leader>l" "<C-w>L" "Move window far right")

    # Flip the layout between stacked and side-by-side. These were bare `,` and
    # `.`, which took away `,` (repeat f/t backwards) and `.` (dot-repeat).
    (map "n" "<Leader>," "<C-w>t<C-w>K" "Stack windows")
    (map "n" "<Leader>." "<C-w>t<C-w>H" "Windows side by side")

    # Resize
    (map "n" "<C-Down>" "<cmd>resize -2<CR>" "Shrink height")
    (map "n" "<C-Up>" "<cmd>resize +2<CR>" "Grow height")
    (map "n" "<C-Left>" "<cmd>vertical resize -2<CR>" "Shrink width")
    (map "n" "<C-Right>" "<cmd>vertical resize +2<CR>" "Grow width")

    # Search
    (map "n" "<Leader><CR>" "<cmd>nohlsearch<CR>" "Clear search highlight")
    (map "n" "n" "nzz" null)
    (map "n" "N" "Nzz" null)

    (map "n" "<C-n>" "<cmd>tabnew<CR>" "New tab")

    # Misc
    (map "n" "<C-u>" "5k" null)
    (map "n" "<C-d>" "5j" null)
    (map [ "n" "x" ] "<C-.>" "$" "End of line")
    (map "i" "<C-.>" "<Esc>$" "End of line")
    (map [ "n" "x" ] "<C-,>" "^" "First non-blank")
    (map "i" "<C-,>" "<Esc>^" "First non-blank")
  ];
}
