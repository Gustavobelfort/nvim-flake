# Press a prefix and wait to see what follows; <Leader>sk searches every map.
{
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "helix";
      spec = [
        {
          __unkeyed-1 = "<Leader>b";
          group = "buffer";
        }
        {
          __unkeyed-1 = "<Leader>c";
          group = "code";
        }
        {
          __unkeyed-1 = "<Leader>d";
          group = "debug";
        }
        {
          __unkeyed-1 = "<Leader>f";
          group = "file";
        }
        {
          __unkeyed-1 = "<Leader>g";
          group = "git";
        }
        {
          __unkeyed-1 = "<Leader>h";
          group = "hunk";
        }
        {
          __unkeyed-1 = "<Leader>q";
          group = "session";
        }
        {
          __unkeyed-1 = "<Leader>s";
          group = "search";
        }
        {
          __unkeyed-1 = "<Leader>u";
          group = "toggle";
        }
        {
          __unkeyed-1 = "<Leader>x";
          group = "diagnostics";
        }
        {
          __unkeyed-1 = "s";
          group = "split";
        }
        {
          __unkeyed-1 = "gs";
          group = "surround";
        }
        {
          __unkeyed-1 = "[";
          group = "previous";
        }
        {
          __unkeyed-1 = "]";
          group = "next";
        }
      ];
    };
  };
}
