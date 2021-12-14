{ home, pkgs, lib, inputs, system, ... }:
let pkgs-shadowsocks-qt5 = pkgs.libsForQt5.callPackage ../packages/gui/shadowsocks-qt5.nix { }; in
let v2ray-geoip = (import inputs.nixpkgs-master { inherit system; }).pkgs.v2ray-geoip; in
let pkgs-gnote = pkgs.callPackage ../packages/gui/gnote.nix { }; in
let pkgs-expac = pkgs.callPackage ../packages/cli/expac.nix { }; in
{
  home.packages = [
    pkgs.gimp-with-plugins
    pkgs.remmina
    (pkgs.callPackage ../packages/gui/motrix.nix { })
    pkgs.qbittorrent
    pkgs.obs-studio
    pkgs.gnome3.baobab

    pkgs.virt-manager

    pkgs.albert
    (pkgs.makeAutostartItem { name = "albert"; package = pkgs.albert; })

    pkgs.atom
    pkgs.rbw
    pkgs.copyq
    pkgs.fortune
    pkgs-gnote
    pkgs.units
    pkgs.goldendict
    pkgs.lastpass-cli
    pkgs.phpPackages.composer
    pkgs-expac
    pkgs.pacman
    pkgs.pass
    pkgs.php
    pkgs.xclip
    pkgs.scrot
    pkgs.tetex
    pkgs.tomboy
    pkgs.imagemagick
    pkgs.wmctrl

    pkgs.dosbox
    (pkgs.callPackage ../packages/gui/openvisualtraceroute.nix { })

    pkgs.fontforge
    pkgs.fontforge-gtk
    pkgs.miraclecast
    pkgs.wpsoffice

    pkgs.mumble
    (pkgs.clapper.overrideAttrs (old: {
      # https://github.com/NixOS/nixpkgs/pull/141985/files
      buildInputs = old.buildInputs ++ (with pkgs; [ appstream-glib libsoup ]);
    }))
    pkgs.rpi-imager

    pkgs.v2ray
    pkgs.qv2ray
    (pkgs.callPackage ../packages/QvPlugin/QvPlugin-Trojan-Go.nix { })
    (pkgs.callPackage ../packages/QvPlugin/QvPlugin-SSR.nix { })
    (pkgs.makeAutostartItem { name = "qv2ray"; package = pkgs.qv2ray; })
    pkgs.nur.repos.linyinfeng.clash-premium
    pkgs.nur.repos.linyinfeng.clash-for-windows
    pkgs-shadowsocks-qt5
  ] ++ [ pkgs.zotero ]
  ++ [ pkgs.playonlinux ];

  # https://qv2ray.net/getting-started/step2.html#download-v2ray-core-files
  home.file.".config/qv2ray/vcore".source = pkgs.runCommand "vcore" { } ''
    mkdir $out/
    ln -s ${pkgs.v2ray}/bin/v2ray $out/v2ray && ln -s ${pkgs.v2ray}/bin/v2ctl $out/v2ctl
    ln -s ${v2ray-geoip}/share/v2ray/geoip.dat $out/geoip.dat
    ln -s ${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat $out/geosite.dat
  '';

  # https://github.com/flightlessmango/MangoHud
  programs.mangohud.enable = true;
  programs.mangohud.enableSessionWide = true;

  programs.zathura.enable = true;
  # https://github.com/edunfelt/zathura#usage
  programs.zathura.extraConfig = lib.readFile (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/edunfelt/zathura/main/rose-pine-dawn";
    sha256 = "sha256-mmr6RSsX5wkj0rkwoMhfVpc5cIWTpbXjwoABCOe586A=";
  });
}
