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
    pkgs.virt-manager-qt

    pkgs.albert
    (pkgs.makeAutostartItem { name = "albert"; package = pkgs.albert; })

    pkgs.libreoffice
    (pkgs.wpsoffice.overrideAttrs (old: {
      version = "11.1.0.10161";
      src = pkgs.fetchurl {
        url = "https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/10161/wps-office_11.1.0.10161.XA_amd64.deb";
        sha256 = "sha256-jKYIRChpPIGDP2/fE0QqnqkFJjjVvcDk11EgdfQAB8M";
      };
      postFixup = old.postFixup + ''
        cd $out/share/applications/
        sed -i 's/Exec=/Exec=steam-run /g' *.desktop
      '';
    }))

    pkgs.wireshark

    # https://www.bilibili.com/video/BV17U4y1H7w1
    pkgs.retroarch
    pkgs.dolphinEmu
    pkgs.mame
    pkgs.dosbox

    pkgs.goverlay
    pkgs.okular
    pkgs.zim
    pkgs.kiwix
    pkgs.zathura

    pkgs.yubioath-desktop
    pkgs.yubikey-manager
    pkgs.yubikey-manager-qt
    pkgs.yubikey-personalization
    pkgs.yubikey-personalization-gui

    pkgs.fontforge
    pkgs.fontforge-gtk
    pkgs.gnome-network-displays
    pkgs.miraclecast

    pkgs.spotify
    pkgs.spotify-qt

    pkgs.mumble
    # https://nixpk.gs/pr-tracker.html?pr=126080
  ];

  # https://github.com/flightlessmango/MangoHud
  programs.mangohud.enable = true;
  programs.mangohud.enableSessionWide = true;
}
