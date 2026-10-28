{
  plugins.markdown-preview = {
    enable = true;
    settings.theme = "dark";
  };

  keymaps = [
    {
      mode = "n";
      key = "<Leader>cp";
      action = "<cmd>MarkdownPreviewToggle<CR>";
      options = {
        silent = true;
        desc = "Toggle Markdown preview";
      };
    }
  ];
}
