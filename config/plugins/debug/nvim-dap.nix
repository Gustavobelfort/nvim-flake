{ pkgs, ... }:
{
  plugins = {
    dap = {
      enable = true;
      signs = {
        dapBreakpoint = {
          text = "●";
          texthl = "DapBreakpoint";
        };
        dapBreakpointCondition = {
          text = "●";
          texthl = "DapBreakpointCondition";
        };
        dapLogPoint = {
          text = "◆";
          texthl = "DapLogPoint";
        };
      };
    };
    dap-go = {
      enable = true;
      settings.delve.path = "${pkgs.delve}/bin/dlv";
    };
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<F6>";
      action.__raw = "function() require('dapui').toggle() end";
      options = {
        silent = true;
        desc = "Toggle DAP UI";
      };
    }
    {
      mode = "n";
      key = "<C-b>";
      action.__raw = "function() require('dap').toggle_breakpoint() end";
      options = {
        silent = true;
        desc = "Toggle breakpoint";
      };
    }
  ];
}
