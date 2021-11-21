{ config, pkgs, lib, inputs, system, ... }:
let
  anime4k = (pkgs.callPackage ./packages/resources/anime4k.nix { });
  metro-for-steam = (pkgs.callPackage ./packages/resources/metro-for-steam.nix { });
  masterPkgs = import inputs.nixpkgs-master { inherit system; };

  stablePkgs = with pkgs; import inputs.nixos-stable {
    inherit system; config.allowUnfree = true;
    overlays = [ (self: super: { inherit abseil-cpp; }) ];
  };

  pkgs-tdesktop = with stablePkgs; (import inputs.nixpkgs {
    inherit system; overlays = [ (self: super: { inherit libsForQt5; }) ];
  }).pkgs.tdesktop;
in
rec {
  # https://github.com/shadowsocks/libQtShadowsocks
  nixpkgs.config.permittedInsecurePackages =
    [ "botan-1.10.17" "openssl-1.0.2u" ];

  nixpkgs.overlays = with masterPkgs;
    [ (self: super: { inherit openjdk11 openjfx15; openjdk17 = openjdk; }) ]
    ++ [ (self: super: { jetbrains = super.jetbrains // { inherit jdk; }; }) ];

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
    (pkgs.callPackage ./packages/cli/navicat-keygen-tools.nix { })

    # https://github.com/bkchr/nixos-config/blob/master/system-with-gui-configuration.nix#L8
    pkgs-tdesktop
    (pkgs.makeAutostartItem { name = "telegramdesktop"; package = pkgs-tdesktop; })

    (pkgs.callPackage ./packages/gui/olympus.nix { })
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
    pkgs.termius

    pkgs.gnome.ghex
    # https://github.com/NixOS/nixpkgs/pull/145542
    stablePkgs.ArchiSteamFarm
    pkgs.dasel
    pkgs.coreutils
  ];

  # https://github.com/TomWright/dasel#put
  # https://www.cyberciti.biz/faq/howto-set-readonly-file-permission-in-linux-unix/
  home.activation."ASF-Vanilla.json" =
    let
      json-file = "~/.config/asf/config/Vanilla.json";
      secrets-dir = "/run/agenix";
      dasel = "${pkgs.dasel}/bin/dasel";
    in
    ''
      rm -f ${json-file} && echo "{}" > ${json-file}
      ${dasel} put string -r json '.SteamLogin' `cat ${secrets-dir}/SteamLogin` -f ${json-file}
      ${dasel} put string -r json '.SteamPassword' `cat ${secrets-dir}/SteamPassword` -f ${json-file}
      ${dasel} put bool -r json '.Enabled' true -f ${json-file}
      chmod u-w ${json-file}
    '';

  # https://github.com/JustArchiNET/ArchiSteamFarm/wiki/FAQ-zh-CN
  home.file.".config/asf/config/ASF.json".text =
    builtins.toJSON { "Statistics" = false; "UpdateChannel" = 0; };

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
