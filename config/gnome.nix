{ home, pkgs, ... }:
{
  home.packages = [
    pkgs.gnome.gnome-tweak-tool
    pkgs.qt5ct

    (pkgs.callPackage ../packages/themes/layan-gtk-theme.nix { })
    pkgs.breeze-gtk
    pkgs.tela-icon-theme
    (pkgs.callPackage ../packages/themes/flat-remix-gnome.nix { })

    pkgs.gnomeExtensions.unite
    pkgs.gnomeExtensions.gnome-shell-extension-runcat
    pkgs.gnomeExtensions.gnome-shell-extension-jiggle
    pkgs.gnomeExtensions.gnome-shell-extension-espresso
    pkgs.gnomeExtensions.gnome-shell-extension-blur-me
    pkgs.gnomeExtensions.gnome-shell-extension-openweather
    pkgs.gnomeExtensions.gnome-shell-extension-tray-icons
    pkgs.gnomeExtensions.gnome-shell-extension-simple-net-speed
    pkgs.gnomeExtensions.gnome-shell-extension-proxy-switcher
    pkgs.gnomeExtensions.gnome-shell-extension-extension-list
    pkgs.gnomeExtensions.gnome-shell-extension-eclipse
    pkgs.gnomeExtensions.gnome-shell-extension-screenshot-tool

    # Credit: @Cyunrei
    pkgs.gnomeExtensions.gnome-shell-extension-bluetooth-quick-connect
    pkgs.gnomeExtensions.gnome-shell-extension-extensions-in-system-menu
    (pkgs.callPackage ../packages/gnome/dash-to-dock-gnome40.nix { })

    # https://www.linuxlinks.com/excellent-gnome-desktop-extensions/
    pkgs.gnomeExtensions.arcmenu
    pkgs.gnomeExtensions.gsconnect

    # https://extensions.gnome.org/
    pkgs.gnomeExtensions.sound-output-device-chooser
    pkgs.gnomeExtensions.gnome-shell-extension-status-area-horizontal-spacing
    pkgs.gnomeExtensions.gnome-shell-extension-window-is-ready-notification-remover
    (pkgs.callPackage ../packages/gnome/lockkeys.nix { })
    pkgs.gnomeExtensions.gnome-shell-extension-disconnect-wifi
    pkgs.conky
  ];

  # https://wiki.archlinux.org/title/GTK_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
  home.file.".config/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name = Tela-pink
    gtk-theme-name = Layan-light-solid
  '';
}
