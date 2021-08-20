{ programs, pkgs, home, ... }:
{
  programs.neovim.enable = true;
  programs.neovim = {
    # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/nixos/modules/programs/neovim.nix#L66
    plugins = [
      pkgs.vimPlugins.doki-theme-vim

      # https://github.com/vim-airline/vim-airline#themes
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-airline-themes

      pkgs.vimPlugins.vim-polyglot
      pkgs.vimPlugins.vim-lastplace
      # pkgs.vimPlugins.tabnine-vim
      pkgs.vimPlugins.editorconfig-vim

      pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.coc-tabnine

      pkgs.vimPlugins.nvim-lspconfig
      # https://github.com/NvChad/NvChad
      # pkgs.vimPlugins.lspkind-nvim

      # https://github.com/kyazdani42/nvim-tree.lua#install
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.nvim-tree-lua

      # https://github.com/nvim-telescope/telescope.nvim#installation
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.telescope-nvim

      pkgs.vimPlugins.indent-blankline-nvim

      # https://github.com/glepnir/galaxyline.nvim#install
      # pkgs.vimPlugins.galaxyline-nvim
      # pkgs.vimPlugins.nvim-web-devicons
      # pkgs.vimPlugins.vim-devicons

      # https://github.com/akinsho/nvim-bufferline.lua#installation
      pkgs.vimPlugins.nvim-bufferline-lua
      pkgs.vimPlugins.nvim-web-devicons
    ];

    # https://github.com/doki-theme/doki-theme-vim#installation
    # https://github.com/doki-theme/doki-theme-vim/tree/master/colors
    # https://medium.com/@hql287/10-vim-tips-to-ease-the-learning-curve-c8234cbdafa5
    # https://vimjc.com/vim-powerline.html
    extraConfig = ''
      syntax enable
      set number
      set showtabline=2

      " https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rnix
      lua require'lspconfig'.rnix.setup{}

      " lua vim.opt.termguicolors = true
      lua require("bufferline").setup{}
    '';
  };

  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rnix
  home.packages = [ pkgs.rnix-lsp ];
}
