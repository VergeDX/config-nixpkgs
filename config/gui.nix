{ home, pkgs, lib, ... }:
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

    pkgs.wireshark
    pkgs.dosbox

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
    (pkgs.makeAutostartItem { name = "qv2ray"; package = pkgs.qv2ray; })
    pkgs.nur.repos.linyinfeng.clash-premium
    pkgs.nur.repos.linyinfeng.clash-for-windows
  ];

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
