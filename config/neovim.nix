{ programs, pkgs, home, ... }:
{
  programs.neovim.enable = true;
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

      pkgs.vimPlugins.nvim-compe
      pkgs.vimPlugins.compe-tabnine
      pkgs.vimPlugins.nvim-lspconfig

      # https://github.com/NvChad/NvChad/tree/v1.0
      # [1] https://github.com/onsails/lspkind-nvim
      # pkgs.vimPlugins.lspkind-nvim
      # [2] https://github.com/kyazdani42/nvim-tree.lua#install
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.nvim-tree-lua
      # [3] https://github.com/nvim-telescope/telescope.nvim#installation
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.telescope-nvim
      # [4] https://github.com/lukas-reineke/indent-blankline.nvim#install
      pkgs.vimPlugins.indent-blankline-nvim
      # [5] https://github.com/glepnir/galaxyline.nvim#install
      # pkgs.vimPlugins.galaxyline-nvim
      # pkgs.vimPlugins.nvim-web-devicons | lua
      # pkgs.vimPlugins.vim-devicons | vimscript
      # [6] https://github.com/akinsho/bufferline.nvim#installation
      pkgs.vimPlugins.nvim-bufferline-lua
      pkgs.vimPlugins.nvim-web-devicons
      # [7] https://github.com/kyazdani42/nvim-web-devicons#installation
      pkgs.vimPlugins.nvim-web-devicons
      # [8] https://github.com/nvim-treesitter/nvim-treesitter#installation
      # pkgs.vimPlugins.nvim-treesitter
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

      " https://github.com/hrsh7th/nvim-compe/#prerequisite
      set completeopt=menuone,noselect
      " https://github.com/hrsh7th/nvim-compe/#vim-script-config
      let g:compe = {}
      let g:compe.enabled = v:true
      let g:compe.source = {}
      let g:compe.source.nvim_lsp = v:true
      " https://github.com/hrsh7th/nvim-compe/#highlight
      highlight link CompeDocumentation NormalFloat

      " https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rnix
      lua require'lspconfig'.rnix.setup{}
      " https://github.com/tzachar/compe-tabnine#install
      let g:compe.source.tabnine = v:true

      " https://github.com/NvChad/NvChad/blob/v1.0/lua/plugins/nvimtree.lua#L9
      lua vim.o.termguicolors = false

      " https://github.com/akinsho/bufferline.nvim#usage
      " lua vim.opt.termguicolors = true
      lua require("bufferline").setup{}
    '';
  };

  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rnix
  home.packages = with pkgs; [ rnix-lsp bash ];
}
