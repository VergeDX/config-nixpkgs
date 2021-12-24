{ config, pkgs, lib, inputs, system, ... }:
let
  anime4k = (pkgs.callPackage ./packages/resources/anime4k.nix { });
  metro-for-steam = (pkgs.callPackage ./packages/resources/metro-for-steam.nix { });
  subconverter-bin = (pkgs.callPackage ./packages/services/subconverter-bin.nix { });
  pkgsOld = import inputs.nixpkgs-old { inherit system; };
  pkgsMaster = import inputs.nixpkgs-master { inherit system; };
in
rec {
  # https://github.com/shadowsocks/libQtShadowsocks
  nixpkgs.config.permittedInsecurePackages =
    [ "botan-1.10.17" "openssl-1.0.2u" ];

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
    # pkgs.tdesktop
    # (pkgs.makeAutostartItem { name = "telegramdesktop"; package = pkgs.tdesktop; })
    # https://github.com/NixOS/nixpkgs/pull/148672
    pkgs.nur.repos.ilya-fedin.kotatogram-desktop
    (pkgs.makeAutostartItem {
      name = "kotatogramdesktop";
      package = pkgs.nur.repos.ilya-fedin.kotatogram-desktop;
    })

    (pkgs.callPackage ./packages/gui/olympus.nix { })
    pkgs.stellarium

    pkgs.vlc

    pkgs.gnome.dconf-editor
    pkgs.amule

    pkgs.nodePackages.http-server
    pkgs.nur.repos.plabadens.filebrowser

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
    pkgs.etcher

    pkgs.testdisk

    pkgs.helvum
    pkgs.dmenu
    pkgs.termius

    pkgs.gnome.ghex
    # https://github.com/NixOS/nixpkgs/pull/147322
    pkgsMaster.ArchiSteamFarm
    pkgs.dasel
    pkgs.coreutils
  ] ++ [
    pkgsOld.appimagekit
    pkgsOld.appimage-run
  ] ++ [ pkgs.protontricks ];

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

  # https://stackoverflow.com/questions/19161960/connect-with-ssh-through-a-proxy
  programs.ssh.extraConfig = ''
    Host 107.173.141.139
      ProxyCommand nc -X 5 -x 127.0.0.1:1089 %h %p
  '';

  # https://github.com/JustArchiNET/ArchiSteamFarm/wiki/FAQ-zh-CN
  home.file.".config/asf/config/ASF.json".text =
    builtins.toJSON { "Statistics" = false; "UpdateChannel" = 0; };

  nixpkgs.config.allowUnfree = true;
  imports = [
    ./config/fcitx5.nix
    ./config/git.nix
    ./config/shells.nix
    ./config/zsh.nix
    ./config/neovim.nix

    ./config/fonts.nix
    ./config/gnome.nix
    ./config/browser.nix
    ./config/terminal.nix
    ./config/cli.nix
    ./config/develop.nix

    ./config/gui.nix
    # https://github.com/NixOS/nixpkgs/issues/131282

    ./config/vscode.nix
    ./config/ssh-proxy.nix
  ];

  home.sessionVariables = { NIXPKGS_ALLOW_UNFREE = 1; };

  # https://www.reddit.com/r/pcmasterrace/comments/6u68jw/steam_skins_on_linux/
  home.file.".local/share/Steam/skins/".source = metro-for-steam;

  # https://nix-community.github.io/home-manager/options.html#opt-systemd.user.services
  # systemd.user.services."subconverter" = {
  #   Service."ExecStart" = "${subconverter-bin}/subconverter";
  #   # https://superuser.com/questions/1025091/start-a-systemd-user-service-at-boot
  #   Install."WantedBy" = [ "default.target" ];
  # };
}
