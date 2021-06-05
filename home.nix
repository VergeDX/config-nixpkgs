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

  # https://github.com/nix-community/home-manager/issues/605
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.nixpkgs-fmt
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk
    pkgs.noto-fonts-extra
    pkgs.noto-fonts-emoji
    pkgs.noto-fonts-emoji-blob-bin

    # /nix/store/jz2fqzfq4z664q5dcpmxk5kd7l0phgrd-v2ray-assets
    (import ./qv2ray-pre.nix)
    (pkgs.makeAutostartItem { name = "qv2ray"; package = (import ./qv2ray-pre.nix); })
    pkgs.v2ray

    pkgs.xfce.terminal
    pkgs.powerline-go
    # https://github.com/rofl0r/proxychains-ng
    (pkgs.proxychains.overrideAttrs (old: { configureScript = "./configure --sysconfdir=.config"; }))
    pkgs.neovim

    pkgs.gnome.gnome-tweak-tool
    (import ./layan-gtk-theme.nix)
    pkgs.breeze-gtk
    pkgs.tela-icon-theme
    pkgs.gnomeExtensions.unite
    pkgs.gnomeExtensions.runcat
    pkgs.gnomeExtensions.jiggle
    pkgs.gnomeExtensions.espresso
    pkgs.gnomeExtensions.blur-me
    pkgs.gnomeExtensions.openweather
    pkgs.gnomeExtensions.tray-icons
    pkgs.gnomeExtensions.screenshot-tool
    pkgs.gnomeExtensions.simple-net-speed

    pkgs.arion
    pkgs.apfs-fuse

    # https://github.com/bkchr/nixos-config/blob/master/system-with-gui-configuration.nix#L8
    pkgs.tdesktop
    (pkgs.makeAutostartItem { name = "telegramdesktop"; package = pkgs.tdesktop; })

    # nixpkgs.config.allowUnfree = true;
    pkgs.google-chrome
    (pkgs.steam.override { withPrimus = true; })
    pkgs.vscode
  ];

  nixpkgs.config.allowUnfree = true;

  # https://github.com/yrashk/nix-home/blob/master/home.nix#L269
  home.file.".config/proxychains.conf".text = ''
    [ProxyList]
    socks5  127.0.0.1 1089
  '';
}
