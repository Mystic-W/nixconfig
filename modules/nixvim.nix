{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      clipboard = "unnamedplus";
      termguicolors = true;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # csvview.nvim is not something we need to over-abstract right now.
    # Use nixpkgs' packaged Vim plugin directly.
    extraPlugins = with pkgs.vimPlugins; [
      csvview-nvim
    ];

    extraConfigLua = ''
      require("csvview").setup({
        parser = {
          comments = { "#", "//" },
        },
        view = {
          display_mode = "border",
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "csv", "tsv" },
        callback = function()
          vim.cmd("CsvViewEnable")
        end,
      })
    '';
  };
}
