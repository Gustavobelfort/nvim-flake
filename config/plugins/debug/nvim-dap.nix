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

  keymaps =
    let
      dap = key: lua: desc: {
        mode = "n";
        inherit key;
        action.__raw = "function() ${lua} end";
        options = {
          silent = true;
          inherit desc;
        };
      };
    in
    [
      (dap "<F6>" "require('dapui').toggle()" "Toggle DAP UI")
      (dap "<Leader>du" "require('dapui').toggle()" "Toggle DAP UI")
      # Was <C-b>, which took away scroll-back-a-page.
      (dap "<Leader>db" "require('dap').toggle_breakpoint()" "Toggle breakpoint")
      (dap "<Leader>dB" "require('dap').set_breakpoint(vim.fn.input('Condition: '))"
        "Conditional breakpoint"
      )
      (dap "<Leader>dc" "require('dap').continue()" "Continue")
      (dap "<Leader>di" "require('dap').step_into()" "Step into")
      (dap "<Leader>do" "require('dap').step_over()" "Step over")
      (dap "<Leader>dO" "require('dap').step_out()" "Step out")
      (dap "<Leader>dr" "require('dap').repl.toggle()" "Toggle REPL")
      (dap "<Leader>dt" "require('dap').terminate()" "Terminate")
    ];
}
