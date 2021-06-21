{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "20.09";

  home.username = "vanilla";
  home.homeDirectory = "/home/vanilla";

  home.packages = [
    pkgs.nixpkgs-fmt

    # /nix/store/jz2fqzfq4z664q5dcpmxk5kd7l0phgrd-v2ray-assets
    (pkgs.callPackage ./packages/gui/qv2ray-pre.nix { })
    (pkgs.makeAutostartItem { name = "qv2ray"; package = (pkgs.callPackage ./packages/gui/qv2ray-pre.nix) { }; })
    pkgs.v2ray

    pkgs.arion
    pkgs.apfs-fuse
    # https://github.com/HeQuanX/navicat-keygen-tools/blob/main/README.zh-CN.md
    pkgs.appimagekit
    (pkgs.callPackage ./packages/cli/navicat-keygen-tools.nix { })
    pkgs.appimage-run
    pkgs.texlive.combined.scheme-full

    # https://nixos.wiki/wiki/Wine
    pkgs.wineWowPackages.stable
    pkgs.wineWowPackages.fonts
    (pkgs.winetricks.override { wine = pkgs.wineWowPackages.stable; })

    # https://github.com/bkchr/nixos-config/blob/master/system-with-gui-configuration.nix#L8
    pkgs.tdesktop
    (pkgs.makeAutostartItem { name = "telegramdesktop"; package = pkgs.tdesktop; })

    (pkgs.steam.override {
      withPrimus = true;
      # https://github.com/NixOS/nixpkgs/pull/126142
      # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/games/steam/fhsenv.nix#L241
      extraLibraries = pkgs: [ pkgs.pipewire.lib ];
    })
    pkgs.steam-run
    pkgs.osu-lazer
    (pkgs.callPackage ./packages/gui/olympus.nix { })
    pkgs.minecraft
    pkgs.multimc
    pkgs.stellarium
  ];

  nixpkgs.config.allowUnfree = true;
  imports = [
    ./config/fcitx5.nix
    ./config/git.nix
    ./config/fish.nix
    ./config/neovim.nix
    ./config/zsh.nix

    ./config/ctf.nix
    ./config/fonts.nix
    ./config/gnome.nix
    ./config/browser.nix
    ./config/terminal.nix
    ./config/cli.nix
    ./config/develop.nix
    ./config/gui.nix
  ];
}
