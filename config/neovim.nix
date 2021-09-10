{ programs, pkgs, home, ... }:
let
  sudormrfbin-cheatsheet-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "sudormrfbin-cheatsheet-nvim";
    src = pkgs.fetchgit {
      url = "https://github.com/sudormrfbin/cheatsheet.nvim";
      sha256 = "sha256-17PddcrUpgOzlSG2xaddDpdfRMtjCH5XYpZoSsmrWKo=";
    };
  };

  terrortylor-nvim-comment = pkgs.vimUtils.buildVimPlugin {
    name = "terrortylor-nvim-comment";
    src = pkgs.fetchgit {
      url = "https://github.com/terrortylor/nvim-comment";
      sha256 = "sha256-wv4scKfo4EyHLnP7zOHOhQ4Z7ok8lOvB/NS4RpX9Lg0=";
    };

    preBuild = "rm ./Makefile";
  };

  Pocco81-AutoSave-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "Pocco81-AutoSave-nvim";
    src = pkgs.fetchgit {
      url = "https://github.com/Pocco81/AutoSave.nvim";
      sha256 = "sha256-+CENz+8nE90kjqiaH1e2Bg3y4wQ5Q8KiDi2FddBXFAo=";
    };
  };
in
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
      pkgs.vimPlugins.lspkind-nvim
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
      pkgs.vimPlugins.bufferline-nvim
      pkgs.vimPlugins.nvim-web-devicons
      # [7] https://github.com/kyazdani42/nvim-web-devicons#installation
      pkgs.vimPlugins.nvim-web-devicons
      # [8] https://github.com/nvim-treesitter/nvim-treesitter#installation
      # pkgs.vimPlugins.nvim-treesitter
    ] ++ [
      # https://github.com/norcalli/nvim-colorizer.lua#installation-and-usage
      # pkgs.vimPlugins.nvim-colorizer-lua
      # https://github.com/ray-x/lsp_signature.nvim#install
      pkgs.vimPlugins.lsp_signature-nvim
      # https://github.com/sbdchd/neoformat/#install
      pkgs.vimPlugins.neoformat
      # https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation
      pkgs.vimPlugins.telescope-fzf-native-nvim
      # https://github.com/sudormrfbin/cheatsheet.nvim#installation
      sudormrfbin-cheatsheet-nvim
      pkgs.vimPlugins.popup-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.telescope-nvim
      # https://github.com/lewis991/gitsigns.nvim#installation
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.gitsigns-nvim
      # https://github.com/windwp/nvim-autopairs
      pkgs.vimPlugins.nvim-autopairs
      # https://github.com/terrortylor/nvim-comment#via-a-plugin-manager
      terrortylor-nvim-comment
      # https://github.com/glepnir/dashboard-nvim#install
      pkgs.vimPlugins.dashboard-nvim
      # https://github.com/Pocco81/AutoSave.nvim#adding-the-plugin
      Pocco81-AutoSave-nvim
      # https://github.com/karb94/neoscroll.nvim#installation
      pkgs.vimPlugins.neoscroll-nvim
      # https://github.com/tpope/vim-fugitive
      pkgs.vimPlugins.vim-fugitive
    ];

    # https://github.com/doki-theme/doki-theme-vim#installation
    # https://medium.com/@hql287/10-vim-tips-to-ease-the-learning-curve-c8234cbdafa5
    # https://vimjc.com/vim-powerline.html
    extraConfig = ''
      syntax enable
      set number
      set showtabline=2

      " https://github.com/onsails/lspkind-nvim#configuration
      lua require('lspkind').init()

      " https://github.com/kyazdani42/nvim-tree.lua/issues/549
      set shell=sh

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
      " https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#bashls
      lua require'lspconfig'.bashls.setup{}
      " https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#hls
      lua require'lspconfig'.hls.setup{}
      " https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tsserver
      lua require'lspconfig'.tsserver.setup{}

      " https://github.com/glepnir/dashboard-nvim#faq
      let g:indentLine_fileTypeExclude = ['dashboard']
      " https://github.com/akinsho/bufferline.nvim#usage
      " lua vim.opt.termguicolors = true
      lua require("bufferline").setup{}
    '' + ''
      " https://github.com/norcalli/nvim-colorizer.lua#installation-and-usage
      " lua require'colorizer'.setup()
      " https://github.com/ray-x/lsp_signature.nvim#attach-the-plugin
      lua require "lsp_signature".setup()
      " https://github.com/ray-x/lsp_signature.nvim/issues/1
      lua require'lsp_signature'.on_attach()
      " https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-setup-and-configuration
      lua require('telescope').setup { extensions = { fzf = { fuzzy = true } } }
      lua require('telescope').load_extension('fzf')
      " https://github.com/sudormrfbin/cheatsheet.nvim#configuration
      lua require("cheatsheet").setup()
      " https://github.com/lewis6991/gitsigns.nvim#usage
      lua require('gitsigns').setup { current_line_blame = true }
      " https://github.com/windwp/nvim-autopairs/
      lua require('nvim-autopairs').setup{}
      " https://github.com/terrortylor/nvim-comment#configure
      lua require('nvim_comment').setup()
      " https://github.com/Pocco81/AutoSave.nvim#setup-configuration
      lua require("autosave").setup({ enabled = true })
      " https://github.com/karb94/neoscroll.nvim#quickstart
      lua require('neoscroll').setup()
    '';
  };

  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rnix
  home.packages = with pkgs; [
    rnix-lsp
    nodePackages.bash-language-server
    haskell-language-server
    pkgs.nodePackages.typescript-language-server
  ];
}
