{
  plugins.markdown-preview = {
    enable = true;
    settings.theme = "dark";
  };

  keymaps = [
    {
      mode = "n";
      key = "mp";
      action = "<cmd>MarkdownPreviewToggle<CR>";
      options = {
        silent = true;
        desc = "Toggle Markdown preview";
      };
    }
  ];
}
