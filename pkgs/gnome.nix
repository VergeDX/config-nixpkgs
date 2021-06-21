{ home, pkgs, ... }:
{
  home.packages = [
    pkgs.gnome.gnome-tweak-tool
    (pkgs.callPackage ../packages/themes/layan-gtk-theme.nix { })
    pkgs.breeze-gtk
    pkgs.tela-icon-theme
    (pkgs.callPackage ../packages/themes/flat-remix-gnome.nix { })
    pkgs.gnomeExtensions.unite
    pkgs.gnomeExtensions.runcat
    pkgs.gnomeExtensions.jiggle
    pkgs.gnomeExtensions.espresso
    pkgs.gnomeExtensions.blur-me
    pkgs.gnomeExtensions.openweather
    pkgs.gnomeExtensions.tray-icons
    pkgs.gnomeExtensions.simple-net-speed
    pkgs.gnomeExtensions.proxy-switcher
    pkgs.gnomeExtensions.extension-list
    pkgs.gnomeExtensions.eclipse
    pkgs.gnomeExtensions.screenshot-tool

    # Credit: @Cyunrei
    pkgs.gnomeExtensions.bluetooth-quick-connect
    pkgs.gnomeExtensions.extensions-in-system-menu
    (pkgs.callPackage ../packages/gnome/dash-to-dock-gnome40.nix { })

    # https://www.linuxlinks.com/excellent-gnome-desktop-extensions/
    pkgs.gnomeExtensions.arcmenu
    pkgs.gnomeExtensions.gsconnect

    # https://extensions.gnome.org/
    pkgs.gnomeExtensions.sound-output-device-chooser
    pkgs.gnomeExtensions.status-area-horizontal-spacing
    pkgs.gnomeExtensions.window-is-ready-notification-remover
    (pkgs.callPackage ../packages/gnome/lockkeys.nix { })
    pkgs.gnomeExtensions.disconnect-wifi
    pkgs.conky
  ];
}
