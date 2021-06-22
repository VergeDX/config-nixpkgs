{ home, pkgs, ... }:
{
  home.packages = [
    pkgs.gimp-with-plugins
    pkgs.remmina
    (pkgs.callPackage ../packages/gui/motrix.nix { })
    pkgs.zoom-us
    pkgs.google-play-music-desktop-player
    pkgs.tor-browser-bundle-bin
    pkgs.qbittorrent
    pkgs.obs-studio
    pkgs.gnome3.baobab

    pkgs.virt-manager
    pkgs.virt-manager-qt

    pkgs.albert
    (pkgs.makeAutostartItem { name = "albert"; package = pkgs.albert; })
    (pkgs.callPackage ../packages/gui/edex-ui.nix { })

    pkgs.vscode
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

    (pkgs.callPackage ../packages/gui/google-earth-pro.nix { })
  ];
}
