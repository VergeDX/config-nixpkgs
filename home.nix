{ config, pkgs, lib, ... }:

let
  anime4k = (pkgs.callPackage ./packages/resources/anime4k.nix { });
  # tdesktop-beta = (pkgs.callPackage ./packages/gui/tdesktop-beta.nix { });

  wrapElectronWithProxy = ({ package, binaryName, binaryPath }:
    pkgs.runCommandLocal binaryName { nativeBuildInputs = [ pkgs.makeWrapper ]; }
      ''
        mkdir -p $out
        ${pkgs.xorg.lndir}/bin/lndir -silent ${package} $out
        wrapProgram $out/${binaryPath}/${binaryName} \
          --add-flags '--proxy-server=http://127.0.0.1:8889'
      '');
  discord-with-proxy = (wrapElectronWithProxy rec {
    package = pkgs.discord;
    binaryName = "Discord";
    binaryPath = "opt/${binaryName}";
  });
  element-desktop-with-proxy = (wrapElectronWithProxy rec {
    package = pkgs.element-desktop;
    binaryPath = "bin";
    binaryName = "element-desktop";
  });
in
rec {
  programs.home-manager.enable = true;
  home.stateVersion = "20.09";

  home.username = "vanilla";
  home.homeDirectory = "/home/vanilla";

  home.packages = [
    pkgs.nixpkgs-fmt
    pkgs.update-nix-fetchgit

    (pkgs.callPackage ./packages/gui/qv2ray.nix { })
    (pkgs.makeAutostartItem { name = "qv2ray"; package = (pkgs.callPackage ./packages/gui/qv2ray.nix) { }; })
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

    pkgs.steam-run
    # pkgs.osu-lazer
    (pkgs.callPackage ./packages/gui/olympus.nix { })
    # pkgs.minecraft
    # pkgs.multimc
    pkgs.stellarium

    pkgs.vlc

    pkgs.gnome.dconf-editor
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.amule
    pkgs.gnome.polari

    discord-with-proxy
    pkgs.betterdiscord-installer
    pkgs.betterdiscordctl
    pkgs.nodePackages.http-server
    element-desktop-with-proxy

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

    pkgs.minecraft-server
    pkgs.mkvtoolnix
    pkgs.testdisk
    pkgs.gnome.gnome-boxes

    pkgs.helvum

    # pkgs.lutris
    # pkgs.playonlinux
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
}
