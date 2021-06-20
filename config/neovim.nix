{ programs, pkgs, ... }:
let
  doki-theme-vim = (pkgs.callPackage ../packages/themes/doki-theme-vim.nix) { };
  tabnine-vim = (pkgs.callPackage ../packages/resources/tabnine-vim.nix) { };
in
{
  programs.neovim.enable = true;
  programs.neovim = {
    # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/nixos/modules/programs/neovim.nix#L66
    plugins = [
      doki-theme-vim
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-airline-themes
      pkgs.vimPlugins.vim-polyglot
      pkgs.vimPlugins.vim-lastplace
    ];

    # https://github.com/doki-theme/doki-theme-vim#installation
    # https://github.com/doki-theme/doki-theme-vim/tree/master/colors
    # https://medium.com/@hql287/10-vim-tips-to-ease-the-learning-curve-c8234cbdafa5
    # https://vimjc.com/vim-powerline.html
    extraConfig = ''
      packadd! ${doki-theme-vim.pkadd-name}
      syntax enable
      colorscheme emilia_dark
      set number
      set showtabline=2
      set rtp+=${tabnine-vim.out}/${tabnine-vim.name}
    '';
  };
}
