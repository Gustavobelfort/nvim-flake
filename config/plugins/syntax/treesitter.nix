{
  # All grammars come prebuilt from Nix (the module's default), so nothing is
  # compiled or downloaded at runtime.
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;
    folding.enable = true;
  };
}
