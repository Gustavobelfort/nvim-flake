# Shows the diagnostic under the cursor inline, at the end of the line. Replaces
# a CursorHold autocmd that opened a float, which with a short updatetime popped
# up whenever the cursor paused.
{
  plugins.tiny-inline-diagnostic = {
    enable = true;
    settings.preset = "modern";
  };
}
