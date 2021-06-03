{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vanilla";
  home.homeDirectory = "/home/vanilla";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  # https://github.com/nix-community/home-manager#keeping-your--safe-from-harm
  programs.git.enable = true;
  programs.git.userName = "Vanilla";
  programs.git.userEmail = "neko@hydev.org";

  # https://github.com/justjanne/powerline-go#fish
  programs.fish.enable = true;
  programs.fish.shellInit = ''
    function fish_prompt
        eval powerline-go -error $status -jobs (jobs -p | wc -l)
    end
  '';

  home.packages = [
    pkgs.nixpkgs-fmt

    # /nix/store/jz2fqzfq4z664q5dcpmxk5kd7l0phgrd-v2ray-assets
    (import ./qv2ray-pre.nix)
    pkgs.v2ray

    pkgs.xfce.terminal
    pkgs.powerline-go
  ];
}
