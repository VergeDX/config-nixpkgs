{ home, pkgs, lib, buildGnomeExtension, ... }:
let forceGNOME41 = version: extension: (extension.overrideAttrs (old: {
  # https://gitlab.com/jenslody/gnome-shell-extension-openweather/-/merge_requests/248/diffs
  patchPhase = ''sed -i 's/"${version}"/"${version}", "41"/g' metadata.json'';
})); in
let Fildem-GNOME = pkgs.callPackage ../packages/cli/Fildem/Fildem-GNOME.nix { }; in
let fildem = pkgs.callPackage ../packages/cli/Fildem/Fildem-run.nix { }; in
let Schneegans.Fly-Pie = pkgs.callPackage ../packages/gnome/Fly-Pie.nix { }; in
let Fluent-gtk-theme = pkgs.callPackage ../packages/gnome/Fluent-gtk-theme.nix { }; in
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

    Fluent-gtk-theme

    pkgs.gnomeExtensions.unite
    # pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.runcat
    pkgs.gnomeExtensions.espresso
    # pkgs.gnomeExtensions.blur-me
    pkgs.gnomeExtensions.blur-my-shell
    (forceGNOME41 "40" pkgs.gnomeExtensions.openweather)
    # (forceGNOME41 "40.0" pkgs.gnomeExtensions.tray-icons)
    pkgs.gnomeExtensions.simple-net-speed
    pkgs.gnomeExtensions.proxy-switcher
    # pkgs.gnomeExtensions.extension-list
    (forceGNOME41 "40" pkgs.gnomeExtensions.screenshot-tool)

    # Credit: @Cyunrei
    pkgs.gnomeExtensions.bluetooth-quick-connect
    # pkgs.gnomeExtensions.extensions-in-system-menu
    pkgs.gnomeExtensions.dash-to-dock

    # https://www.linuxlinks.com/excellent-gnome-desktop-extensions/
    pkgs.gnomeExtensions.arcmenu
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

    # https://www.reddit.com/r/linux/comments/ri496j/theres_snow_place_like_gnome/
    pkgs.gnomeExtensions.downfall
  ] ++ [ Schneegans.Fly-Pie ] ++ [
    # https://gitlab.gnome.org/GNOME/nautilus/-/issues/2053
    (pkgs.gnome.nautilus.overrideAttrs (old: {
      patches = old.patches ++ (lib.singleton (pkgs.fetchurl {
        url = "https://gitlab.gnome.org/GNOME/nautilus/-/merge_requests/722.patch";
        hash = "sha256-ncB7WbHGcMJirLnkig4HQQM33aq0s2IeGzMNvvUVSTA=";
      }));
    }))

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
  ++ [ pkgs.gnome.gnome-dictionary ]
  ++ [ Fildem-GNOME (pkgs.hiPrio fildem) ]
  ++ [ pkgs.lm_sensors ] # Required by sensory.
  ++ [ pkgs.nur.repos.vanilla.gnome-text-editor ]
  ++ [ pkgs.gnome.gnome-font-viewer ];

  # https://github.com/gonzaarcr/Fildem#configuration
  gtk.gtk2.extraConfig = "gtk-modules=\"appmenu-gtk-module\"";
  gtk.gtk3.extraConfig."gtk-modules" = "appmenu-gtk-module";

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
