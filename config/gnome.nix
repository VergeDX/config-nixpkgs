{ home, pkgs, lib, ... }:
{
  home.packages = [
    pkgs.gnome.gnome-tweak-tool
    pkgs.qt5ct

    pkgs.layan-gtk-theme
    pkgs.breeze-gtk
    pkgs.tela-icon-theme
    pkgs.flat-remix-gnome
    pkgs.whitesur-gtk-theme
    pkgs.whitesur-icon-theme

    pkgs.gnomeExtensions.unite
    pkgs.gnomeExtensions.runcat
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
    (pkgs.gnomeExtensions.arcmenu.overrideAttrs (old: {
      src = old.src.overrideAttrs (old: { outputHash = "sha256-HOxruic/8/R2NS51qZpPIEXdjuhG3J/ALXBVBHiq+iQ="; });
    }))
    pkgs.gnomeExtensions.gsconnect

    # https://extensions.gnome.org/
    pkgs.gnomeExtensions.sound-output-device-chooser
    pkgs.gnomeExtensions.status-area-horizontal-spacing
    pkgs.gnomeExtensions.window-is-ready-remover
    pkgs.gnomeExtensions.lock-keys
    pkgs.gnomeExtensions.disconnect-wifi

    # https://askubuntu.com/questions/1234742/automatic-light-dark-mode
    pkgs.gnomeExtensions.night-theme-switcher

    pkgs.conky
    pkgs.gpick

    # https://github.com/cutefishos
    (pkgs.callPackage ../packages/cutefish/icons.nix { })
  ];

  gtk.enable = true;
  gtk.iconTheme = { package = pkgs.tela-icon-theme; name = "Tela-pink"; };
  gtk.theme = { package = pkgs.layan-gtk-theme; name = "Layan-light-solid"; };
}
