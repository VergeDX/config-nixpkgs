{ programs, pkgs, home, ... }:
let
  terrortylor-nvim-comment = pkgs.vimUtils.buildVimPlugin rec {
    pname = "terrortylor-nvim-comment";
    version = "6363118";

    src = pkgs.fetchgit {
      url = "https://github.com/terrortylor/nvim-comment";
      rev = "${version}acf86824ed11c2238292b72dc5ef8bdde";
      sha256 = "sha256-wv4scKfo4EyHLnP7zOHOhQ4Z7ok8lOvB/NS4RpX9Lg0=";
    };

    preBuild = "rm ./Makefile";
  };

  Pocco81-AutoSave-nvim = pkgs.vimUtils.buildVimPlugin rec {
    pname = "Pocco81-AutoSave-nvim";
    version = "b1df927";

    src = pkgs.fetchgit {
      url = "https://github.com/Pocco81/AutoSave.nvim";
      rev = "abe94790b4fd1d423ac825c2ac09898e8";
      sha256 = "sha256-+CENz+8nE90kjqiaH1e2Bg3y4wQ5Q8KiDi2FddBXFAo=";
    };
  };

  rose-pine-neovim = pkgs.vimUtils.buildVimPlugin rec {
    pname = "rose-pine-neovim";
    version = "v0.0.1";

    src = pkgs.fetchgit {
      url = "https://github.com/rose-pine/neovim";
      rev = version;
      sha256 = "sha256-OLlutTnMQiCYLmnwkAXiyuhp62DBmpxq3z0No3buHcg=";
    };
  };

  tzachar-cmp-tabnine = pkgs.vimUtils.buildVimPlugin rec {
    pname = "tzachar-cmp-tabnine";
    version = "c3a168e";

    src = pkgs.fetchgit {
      url = "https://github.com/tzachar/cmp-tabnine";
      rev = "${version}d3f27ddaa8e05e623bea65f99cd7be7e6";
      sha256 = "sha256-CNvqT9Z5YGMnehulgPIuZIkhSboyuAGFdIDf47xyEYc=";
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
  programs.neovim = {
    # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/nixos/modules/programs/neovim.nix#L66
    plugins = [
      rose-pine-neovim
      pkgs.vimPlugins.lualine-nvim

      pkgs.vimPlugins.vim-polyglot
      pkgs.vimPlugins.vim-lastplace
      pkgs.vimPlugins.editorconfig-vim

      # https://github.com/tzachar/compe-tabnine/#warning
      # https://github.com/hrsh7th/nvim-cmp#install
      pkgs.vimPlugins.nvim-cmp
      # https://github.com/hrsh7th/vim-vsnip/#1-install
      pkgs.vimPlugins.vim-vsnip
      pkgs.vimPlugins.vim-vsnip-integ
      pkgs.vimPlugins.cmp-buffer
      tzachar-cmp-tabnine
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
      set shell=sh

      " https://github.com/hrsh7th/nvim-cmp#basic-configuration
      " https://github.com/hrsh7th/cmp-buffer#setup
      " https://github.com/tzachar/cmp-tabnine#install
      " https://github.com/tzachar/cmp-tabnine#pretty-printing-menu-items
      " lua require'cmp'.setup({ sources = { { name = 'buffer' }, { name = 'cmp_tabnine' } } })

      lua << EOF
      local lspkind = require('lspkind')

      local source_mapping = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        cmp_tabnine = "[TN]",
        path = "[Path]",
      }

      require'cmp'.setup {
        sources = {
          { name = 'cmp_tabnine' },
          { name = 'buffer' },
          { name = 'cmp_tabnine' },
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == 'cmp_tabnine' then
              if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                menu = entry.completion_item.data.detail .. ' ' .. menu
              end
              vim_item.kind = ''
            end
            vim_item.menu = menu
            return vim_item
          end
        },
      }
      EOF

      " https://github.com/hrsh7th/vim-vsnip/#2-setting
      let g:vsnip_filetypes = {}
      let g:vsnip_filetypes.javascriptreact = ['javascript']
      let g:vsnip_filetypes.typescriptreact = ['typescript']

      " https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rnix
      lua require'lspconfig'.rnix.setup{}

      " https://github.com/tzachar/cmp-tabnine#setup
      lua << EOF
      local tabnine = require('cmp_tabnine.config')
      tabnine:setup({
              max_lines = 1000;
              max_num_results = 20;
              sort = true;
      })
      EOF

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
    nodePackages.typescript-language-server
  ];
}
