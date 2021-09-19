{ home, pkgs, ... }:
{
  home.packages = [
    pkgs.gimp-with-plugins
    pkgs.remmina
    (pkgs.callPackage ../packages/gui/motrix.nix { })
    pkgs.google-play-music-desktop-player
    pkgs.qbittorrent
    pkgs.obs-studio
    pkgs.gnome3.baobab

    pkgs.virt-manager

    pkgs.albert
    (pkgs.makeAutostartItem { name = "albert"; package = pkgs.albert; })

    pkgs.libreoffice
    pkgs.wpsoffice

    pkgs.wireshark

    # https://www.bilibili.com/video/BV17U4y1H7w1
    # pkgs.retroarch
    # pkgs.dolphinEmu
    # pkgs.mame
    # pkgs.dosbox

    pkgs.goverlay

    pkgs.yubioath-desktop
    pkgs.yubikey-manager
    pkgs.yubikey-manager-qt
    pkgs.yubikey-personalization
    pkgs.yubikey-personalization-gui

    pkgs.fontforge
    pkgs.fontforge-gtk
    pkgs.gnome-network-displays
    pkgs.miraclecast

    pkgs.mumble
    # https://nixpk.gs/pr-tracker.html?pr=126080
  ];

  # https://github.com/flightlessmango/MangoHud
  programs.mangohud.enable = true;
  programs.mangohud.enableSessionWide = true;
}
