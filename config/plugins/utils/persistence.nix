# Saves a session per working directory on exit. Sessions live under
# ~/.local/state/nvim, which erebus persists across the root wipe.
{
  plugins.persistence.enable = true;

  keymaps =
    let
      map = key: lua: desc: {
        mode = "n";
        inherit key;
        action.__raw = "function() require('persistence').${lua} end";
        options = {
          silent = true;
          inherit desc;
        };
      };
    in
    [
      (map "<Leader>qs" "load()" "Restore session for this directory")
      (map "<Leader>qS" "select()" "Pick a session")
      (map "<Leader>ql" "load({ last = true })" "Restore last session")
      (map "<Leader>qd" "stop()" "Don't save this session")
    ];
}
