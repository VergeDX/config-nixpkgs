{ programs, pkgs, ... }:
{
  programs.neovim.enable = true;
  programs.neovim = {
    # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/nixos/modules/programs/neovim.nix#L66
    plugins = [
      pkgs.vimPlugins.doki-theme-vim
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-airline-themes
      pkgs.vimPlugins.vim-polyglot
      pkgs.vimPlugins.vim-lastplace
      pkgs.vimPlugins.tabnine-vim
      pkgs.vimPlugins.YouCompleteMe
      pkgs.vimPlugins.doki-theme-vim
      pkgs.vimPlugins.editorconfig-vim
    ];

    # https://github.com/doki-theme/doki-theme-vim#installation
    # https://github.com/doki-theme/doki-theme-vim/tree/master/colors
    # https://medium.com/@hql287/10-vim-tips-to-ease-the-learning-curve-c8234cbdafa5
    # https://vimjc.com/vim-powerline.html
    extraConfig = ''
      syntax enable
      colorscheme emilia_light
      set number
      set showtabline=2
    '';
  };
}
