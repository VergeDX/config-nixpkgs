{ home, pkgs, ... }:
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

    pkgs.mumble
    pkgs.clapper
    pkgs.rpi-imager

    pkgs.v2ray
    pkgs.qv2ray
    (pkgs.makeAutostartItem { name = "qv2ray"; package = pkgs.qv2ray; })
  ];

  # https://github.com/flightlessmango/MangoHud
  programs.mangohud.enable = true;
  programs.mangohud.enableSessionWide = true;
}
