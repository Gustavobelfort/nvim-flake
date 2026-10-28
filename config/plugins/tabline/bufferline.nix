{
  plugins.bufferline = {
    enable = true;
    settings.options = {
      themable = true;
      # Closing from the tabline keeps the window layout, like <Leader>bd.
      close_command.__raw = "function(n) Snacks.bufdelete(n) end";
      right_mouse_command.__raw = "function(n) Snacks.bufdelete(n) end";
      diagnostics = "nvim_lsp";
      offsets = [
        {
          filetype = "snacks_layout_box";
          text = "Explorer";
        }
      ];
    };
  };

  keymaps =
    let
      map = key: cmd: desc: {
        mode = "n";
        inherit key;
        action = "<cmd>${cmd}<CR>";
        options = {
          silent = true;
          inherit desc;
        };
      };
    in
    [
      (map "<S-l>" "BufferLineCycleNext" "Next buffer")
      (map "<S-h>" "BufferLineCyclePrev" "Previous buffer")
      (map "]b" "BufferLineCycleNext" "Next buffer")
      (map "[b" "BufferLineCyclePrev" "Previous buffer")
      (map "<Leader>bp" "BufferLineTogglePin" "Pin buffer")
      (map "<Leader>bP" "BufferLineGroupClose ungrouped" "Delete unpinned buffers")
    ];
}
