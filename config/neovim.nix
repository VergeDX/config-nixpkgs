{ programs, pkgs, home, ... }:
{
  programs.neovim.enable = true;
  programs.neovim.coc.enable = true;
  programs.neovim = {
    # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/nixos/modules/programs/neovim.nix#L66
    plugins = [
      pkgs.vimPlugins.doki-theme-vim
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-airline-clock
      pkgs.vimPlugins.vim-airline-themes

      pkgs.vimPlugins.vim-polyglot
      pkgs.vimPlugins.vim-lastplace
      # Official's is a fork of ycm-core/YouCompleteMe.
      # pkgs.vimPlugins.tabnine-vim
      pkgs.vimPlugins.editorconfig-vim

      # Use module from home-manager instead.
      # pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.coc-tabnine
      pkgs.vimPlugins.nvim-lspconfig
    ];

    # https://github.com/doki-theme/doki-theme-vim#installation
    # https://medium.com/@hql287/10-vim-tips-to-ease-the-learning-curve-c8234cbdafa5
    # https://vimjc.com/vim-powerline.html
    extraConfig = ''
      syntax enable
      set number
      set showtabline=2

      " https://github.com/kyazdani42/nvim-tree.lua/issues/549
      set shell=${pkgs.bash}/bin/bash

      " https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rnix
      lua require'lspconfig'.rnix.setup{}
    '';
  };

  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rnix
  home.packages = with pkgs; [ rnix-lsp bash ];
}
