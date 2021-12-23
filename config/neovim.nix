{ programs, pkgs, home, lib, ... }:
let
  Pocco81-AutoSave-nvim = pkgs.vimUtils.buildVimPlugin rec {
    pname = "Pocco81-AutoSave-nvim";
    version = "140c477";

    src = pkgs.fetchgit {
      url = "https://github.com/Pocco81/AutoSave.nvim";
      rev = "${version}57051706c484525472296ca5213fdf598";
      hash = "sha256-l1REQsT3+hYIf+XReT2DdQOvDyWiNWgvronhgHq0TQg=";
    };
  };

  rose-pine-neovim = pkgs.vimUtils.buildVimPlugin rec {
    pname = "rose-pine-neovim";
    version = "v0.1.0";

    src = pkgs.fetchgit {
      url = "https://github.com/rose-pine/neovim";
      rev = version;
      sha256 = "sha256-PTGSYjU+PTgscB5/KJMUuy9Y0UktamH1q0HQgJdxAiI=";
    };
  };

  github-copilot-vim = pkgs.vimUtils.buildVimPlugin rec {
    pname = "github-copilot-vim";
    version = "1.0.5";

    src = pkgs.fetchgit {
      url = "https://github.com/github/copilot.vim";
      rev = "c01314840b94da0b9767b52f8a4bbc579214e509";
      hash = "sha256-gnFiuXpKF55cWxCXNXe3zqQaVmGoUV5aRBGIlyUUfIM=";
    };
  };

  tzachar-cmp-tabnine = pkgs.vimUtils.buildVimPlugin rec {
    pname = "tzachar-cmp-tabnine";
    version = "ae5c8f3";

    src = pkgs.fetchgit {
      url = "https://github.com/tzachar/cmp-tabnine";
      rev = "${version}6668d4cb5443e763df5f7989a29fc801f";
      hash = "sha256-rS5DberDCuKAEwwHeie6PiRL6MvPwnp7EWM6i2o9Vys=";
    };

    tabnine = pkgs.fetchurl {
      url = "https://update.tabnine.com/bundles/3.6.8/x86_64-unknown-linux-musl/TabNine.zip";
      sha256 = "sha256-+jxjHE2/6IGptMlKXGebHcaIVokOP76ut325EbkdaA0=";
    };

    buildInputs = [ pkgs.unzip ];
    postInstall = ''
      cd $out && mkdir -p binaries/3.6.8/x86_64-unknown-linux-musl
      cd $out/binaries/3.6.8/x86_64-unknown-linux-musl

      # https://github.com/tzachar/cmp-tabnine/blob/main/install.sh#L29
      unzip -o ${tabnine} -d . && chmod +x *
    '';
  };
in
{
  programs.neovim.enable = true;
  programs.neovim.package = pkgs.neovim-unwrapped;

  home.sessionVariables = { EDITOR = "nvim"; };
  programs.neovim = {
    # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/nixos/modules/programs/neovim.nix#L66
    plugins = [
      rose-pine-neovim
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.vim-polyglot
      pkgs.vimPlugins.vim-lastplace
      pkgs.vimPlugins.editorconfig-vim
    ] ++ [
      # https://github.com/tzachar/compe-tabnine/#warning
      # https://github.com/hrsh7th/nvim-cmp#install
      pkgs.vimPlugins.nvim-cmp
      # https://github.com/hrsh7th/nvim-cmp/issues/206
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp-buffer
    ] ++ lib.optionals (! pkgs.stdenv.isAarch64) [
      tzachar-cmp-tabnine
    ] ++ [
      pkgs.vimPlugins.nvim-lspconfig
    ] ++ [
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
      pkgs.vimPlugins.cheatsheet-nvim
      pkgs.vimPlugins.popup-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.telescope-nvim
      # https://github.com/lewis991/gitsigns.nvim#installation
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.gitsigns-nvim
      # https://github.com/windwp/nvim-autopairs
      pkgs.vimPlugins.nvim-autopairs
      # https://github.com/terrortylor/nvim-comment#via-a-plugin-manager
      pkgs.nur.repos.m15a.vimExtraPlugins.nvim-comment
      # https://github.com/glepnir/dashboard-nvim#install
      pkgs.vimPlugins.dashboard-nvim
      # https://github.com/Pocco81/AutoSave.nvim#adding-the-plugin
      Pocco81-AutoSave-nvim
      # https://github.com/karb94/neoscroll.nvim#installation
      pkgs.vimPlugins.neoscroll-nvim
      # https://github.com/tpope/vim-fugitive
      pkgs.vimPlugins.vim-fugitive
    ] ++ [ github-copilot-vim ];

    # https://medium.com/@hql287/10-vim-tips-to-ease-the-learning-curve-c8234cbdafa5
    # https://vimjc.com/vim-powerline.html
    extraConfig = ''
      syntax enable
      set number
      set showtabline=2

      " https://github.com/rose-pine/neovim#options
      lua vim.g.rose_pine_variant = 'dawn'
      lua vim.cmd('colorscheme rose-pine')
      " https://github.com/rose-pine/neovim#usage
      lua require('lualine').setup({ options = { theme = 'rose-pine' } })

      " https://github.com/onsails/lspkind-nvim#configuration
      lua require('lspkind').init()

      " https://github.com/kyazdani42/nvim-tree.lua/issues/549
      set shell=bash
    '' + ''
      " https://github.com/hrsh7th/nvim-cmp#basic-configuration
      " https://github.com/hrsh7th/cmp-buffer#setup
      " https://github.com/tzachar/cmp-tabnine#install

      lua << EOF
      local lspkind = require('lspkind')
      require'cmp'.setup {
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              cmp_tabnine = "[TN]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
        sources = {
          { name = 'buffer' },
          { name = 'nvim_lsp' },
          { name = 'cmp_tabnine' },
          { name = 'path' },
        },
      }
      EOF
    '' + lib.optionalString (! pkgs.stdenv.isAarch64) ''
      lua << EOF
      -- https://github.com/tzachar/cmp-tabnine#setup
      local tabnine = require('cmp_tabnine.config')
      tabnine:setup({
              max_lines = 1000;
              max_num_results = 20;
              sort = true;
      })
      EOF
    '' + ''
      lua << EOF
      -- https://github.com/hrsh7th/cmp-nvim-lsp#setup
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

      -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rnix
      require'lspconfig'.rnix.setup{ capabilities = capabilities, }
      -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tsserver
      require'lspconfig'.tsserver.setup{ capabilities = capabilities, }
      -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#pyright
      require'lspconfig'.pyright.setup{ capabilities = capabilities, }
      -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#yamlls
      require'lspconfig'.yamlls.setup{ capabilities = capabilities, }
      -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#clangd
      require'lspconfig'.clangd.setup{ capabilities = capabilities, }
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cmake
      require'lspconfig'.cmake.setup{ capabilities = capabilities, }
      EOF
    '' + ''
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
      " https://github.com/sbdchd/neoformat#config-optional
      let g:neoformat_enabled_python = ['autopep8', 'yapf', 'docformatter']
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
      " https://github.com/github/copilot.vim/blob/release/doc/copilot.txt
      let b:copilot_disabled = v:false
    '';
  };

  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rnix
  home.packages = with pkgs; [
    rnix-lsp
    nodePackages.bash-language-server
    nodePackages.typescript-language-server
    pyright
    nodePackages.yaml-language-server

    python39Packages.autopep8
    python39Packages.yapf

    python39Packages.pyaml
    pkgs.nodePackages.prettier

    (pkgs.hiPrio pkgs.stylish-haskell)
    pkgs.haskellPackages.hindent

    pkgs.llvmPackages_9.libclang
    pkgs.cmake-language-server
  ];
}
