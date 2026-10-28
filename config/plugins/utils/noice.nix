{
  # Command line, messages and LSP progress in floating windows. Notifications
  # go through snacks.notifier, which noice uses when nvim-notify is absent.
  plugins.noice = {
    enable = true;
    settings.presets = {
      bottom_search = true;
      long_message_to_split = true;
      lsp_doc_border = true;
    };
  };
}
