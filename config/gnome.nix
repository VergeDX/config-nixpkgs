{ home, pkgs, lib, ... }:
let forceGNOME41 = version: extension: (extension.overrideAttrs (old: {
  # https://gitlab.com/jenslody/gnome-shell-extension-openweather/-/merge_requests/248/diffs
  patchPhase = ''sed -i 's/"${version}"/"${version}", "41"/g' metadata.json'';
}));
in
{
  home.packages = [
    pkgs.gnome.gnome-tweak-tool
    pkgs.qt5ct
    pkgs.gjs

    pkgs.layan-gtk-theme
    pkgs.breeze-gtk
    pkgs.tela-icon-theme
    pkgs.flat-remix-gnome
    pkgs.whitesur-gtk-theme
    pkgs.whitesur-icon-theme

    # pkgs.gnomeExtensions.unite
    # pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.runcat
    pkgs.gnomeExtensions.espresso
    # pkgs.gnomeExtensions.blur-me
    pkgs.gnomeExtensions.blur-my-shell
    (forceGNOME41 "40" pkgs.gnomeExtensions.openweather)
    (forceGNOME41 "40.0" pkgs.gnomeExtensions.tray-icons)
    pkgs.gnomeExtensions.simple-net-speed
    pkgs.gnomeExtensions.proxy-switcher
    # pkgs.gnomeExtensions.extension-list
    pkgs.gnomeExtensions.screenshot-tool

    # Credit: @Cyunrei
    pkgs.gnomeExtensions.bluetooth-quick-connect
    # pkgs.gnomeExtensions.extensions-in-system-menu
    pkgs.gnomeExtensions.dash-to-dock

    # https://www.linuxlinks.com/excellent-gnome-desktop-extensions/
    (pkgs.gnomeExtensions.arcmenu.overrideAttrs (old: rec {
      version = "19";
      src = pkgs.fetchgit {
        url = "https://gitlab.com/arcmenu/ArcMenu";
        rev = "v${version}";
        hash = "sha256-GEeONrrH00Tt9tuxhH7Gv5lSZ2D/hFgeGbUstqJsWZo=";
      };
    }))
    # pkgs.gnomeExtensions.gsconnect

    # https://extensions.gnome.org/
    pkgs.gnomeExtensions.sound-output-device-chooser
    pkgs.gnomeExtensions.status-area-horizontal-spacing
    pkgs.gnomeExtensions.window-is-ready-remover
    pkgs.gnomeExtensions.lock-keys
    pkgs.gnomeExtensions.disconnect-wifi

    # https://askubuntu.com/questions/1234742/automatic-light-dark-mode
    # pkgs.gnomeExtensions.night-theme-switcher
    # pkgs.gnomeExtensions.jiggle

    pkgs.conky
    pkgs.gpick

    (forceGNOME41 "40" pkgs.gnomeExtensions.sensory-perception)
    pkgs.gnomeExtensions.vitals
    pkgs.gnomeExtensions.bring-out-submenu-of-power-offlogout-button
    pkgs.gnomeExtensions.kimpanel
  ] ++ [
    pkgs.gnome.nautilus
    pkgs.gnome.sushi
    pkgs.gnome.gnome-disk-utility
    pkgs.gnome.file-roller
  ] ++ [
    pkgs.gnome.gnome-screenshot
    pkgs.gnome.gnome-system-monitor
    pkgs.gnome.gnome-power-manager
    pkgs.gnome.gnome-boxes
  ] ++ [ pkgs.evince pkgs.perlPackages.FileMimeInfo ]
  ++ [ pkgs.gnomeExtensions.hide-top-bar ]
  ++ [ pkgs.gnome.gnome-dictionary ];

  gtk.enable = true;
  gtk.font = { name = "SF Compact Display"; size = 11; };
  gtk.iconTheme = { package = pkgs.tela-icon-theme; name = "Tela-pink"; };
  gtk.theme = { package = pkgs.layan-gtk-theme; name = "Layan-light-solid"; };

  qt.enable = true;
  qt.platformTheme = "gnome";
  qt.style = { package = pkgs.adwaita-qt; name = "adwaita"; };

  xsession.pointerCursor.package = pkgs.libsForQt5.breeze-icons;
  xsession.pointerCursor.defaultCursor = "Breeze_cursors";
  xsession.pointerCursor.name = "Breeze_cursors";

  xdg = { enable = true; mime.enable = true; mimeApps.enable = true; };
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    "x-scheme-handler/ftp" = [ "org.gnome.Nautilus.desktop" ];

    "text/plain" = [ "org.gnome.gedit.desktop" ];
    "application/x-shellscript" = [ "org.gnome.gedit.desktop" ];

    "application/pdf" = [ "org.gnome.Evince.desktop" ];

    # https://www.vimfromscratch.com/articles/how-to-copy-and-paste-a-line-in-vim
    "image/jpeg" = [ "org.gnome.eog.desktop" ];
    "image/png" = [ "org.gnome.eog.desktop" ];

    "application/vnd.openxmlformats-officedocument.presentationml.presentation" =
      [ "wps-office-wpp.desktop" ];
  };
}
