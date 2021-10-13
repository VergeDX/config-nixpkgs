{ config, pkgs, lib, ... }:
let
  anime4k = (pkgs.callPackage ./packages/resources/anime4k.nix { });
  metro-for-steam = (pkgs.callPackage ./packages/resources/metro-for-steam.nix { });
in
rec {
  programs.home-manager.enable = true;
  home.stateVersion = "20.09";

  home.username = "vanilla";
  home.homeDirectory = "/home/vanilla";

  home.packages = [
    pkgs.nixpkgs-fmt
    pkgs.update-nix-fetchgit

    pkgs.arion
    pkgs.apfs-fuse
    # https://github.com/HeQuanX/navicat-keygen-tools/blob/main/README.zh-CN.md
    pkgs.appimagekit
    (pkgs.callPackage ./packages/cli/navicat-keygen-tools.nix { })
    pkgs.appimage-run
    pkgs.texlive.combined.scheme-full

    # https://github.com/bkchr/nixos-config/blob/master/system-with-gui-configuration.nix#L8
    pkgs.tdesktop
    (pkgs.makeAutostartItem { name = "telegramdesktop"; package = pkgs.tdesktop; })

    pkgs.steam-run
    # pkgs.osu-lazer
    (pkgs.callPackage ./packages/gui/olympus.nix { })
    # pkgs.minecraft
    # pkgs.multimc
    pkgs.stellarium

    pkgs.vlc

    pkgs.gnome.dconf-editor
    pkgs.amule

    pkgs.nodePackages.http-server

    pkgs.woeusb
    pkgs.ntfs3g
    pkgs.wimlib

    pkgs.act
    pkgs.drone-cli

    pkgs.fd
    pkgs.ripgrep
    pkgs.zeal

    pkgs.pstree
    pkgs.jq

    pkgs.evcxr
    pkgs.scenebuilder
    pkgs.etcher

    pkgs.testdisk

    pkgs.helvum
    pkgs.dmenu
  ];

  nixpkgs.config.allowUnfree = true;
  imports = [
    ./config/fcitx5.nix
    ./config/git.nix
    ./config/shells.nix
    ./config/neovim.nix

    ./config/fonts.nix
    ./config/gnome.nix
    ./config/browser.nix
    ./config/terminal.nix
    ./config/cli.nix
    ./config/develop.nix
    ./config/gui.nix
    ./config/vscode.nix
  ];

  home.sessionVariables = { NIXPKGS_ALLOW_UNFREE = 1; };

  # https://www.reddit.com/r/pcmasterrace/comments/6u68jw/steam_skins_on_linux/
  home.file.".local/share/Steam/skins/".source = metro-for-steam;
}
