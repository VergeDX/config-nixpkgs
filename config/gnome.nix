{ home, pkgs, lib, ... }:
{
  home.packages = [
    pkgs.gnome.gnome-tweak-tool
    pkgs.qt5ct

    pkgs.layan-gtk-theme
    pkgs.breeze-gtk
    pkgs.tela-icon-theme
    # https://github.com/NixOS/nixpkgs/pull/132032
    (pkgs.flat-remix-gnome.overrideAttrs (old: {
      version = "20210716";
      src = old.src.overrideAttrs (old: { outputHash = "sha256-UAWi4MyqtuSzp5TEkVLYJF7+2tzH/aT60ObNOimCJ4o="; });
    }))

    pkgs.whitesur-gtk-theme
    pkgs.whitesur-icon-theme

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

    pkgs.conky
    pkgs.gpick

    # https://github.com/cutefishos
    (pkgs.callPackage ../packages/cutefish/icons.nix { })
  ];

  # https://wiki.archlinux.org/title/GTK_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
  # https://github.com/NixOS/nixpkgs/blob/master/doc/functions/generators.section.md
  home.file.".config/gtk-3.0/settings.ini".text = lib.generators.toINI { } {
    Settings = {
      gtk-icon-theme-name = "Tela-pink";
      gtk-theme-name = "Layan-light-solid";
    };
  };
}
