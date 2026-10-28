{
  plugins.trouble.enable = true;

  keymaps =
    let
      # Trouble v3 replaced :TroubleToggle with per-mode subcommands.
      trouble = key: cmd: desc: {
        mode = "n";
        inherit key;
        action = "<cmd>Trouble ${cmd}<CR>";
        options = {
          silent = true;
          inherit desc;
        };
      };
    in
    [
      (trouble "<Leader>xx" "diagnostics toggle" "Diagnostics")
      (trouble "<Leader>xX" "diagnostics toggle filter.buf=0" "Buffer diagnostics")
      (trouble "<Leader>xq" "qflist toggle" "Quickfix list")
      (trouble "<Leader>xl" "loclist toggle" "Location list")
      (trouble "<Leader>xt" "todo toggle" "Todo comments")
      (trouble "<Leader>cs" "symbols toggle focus=false" "Symbols outline")
    ];
}
