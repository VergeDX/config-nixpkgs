{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.displayManager.gdm.nvidiaWayland = true;
  # https://wiki.archlinux.org/title/GDM
  services.xserver.displayManager.defaultSession = "gnome-xorg";

  services.xserver.desktopManager.gnome.enable = true;
  # https://wiki.archlinux.org/title/GNOME/Flashback
  services.xserver.desktopManager.gnome.flashback.enableMetacity = true;

  # https://nixos.wiki/wiki/GNOME#Excluding_some_GNOME_applications_from_the_default_install
  services.gnome.core-utilities.enable = false;
  services.gnome.core-developer-tools.enable = false;

  # Configure keymap in X11
  services.xserver.layout = "us";
  # https://wiki.archlinux.org/title/Xorg/Keyboard_configuration
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  environment.systemPackages = [
    pkgs.epiphany # ------ # Web
    pkgs.gnome.geary # --- # Mail
    pkgs.gnome.gedit # --- # Calendar
    pkgs.lollypop # ------ # Music
    pkgs.gnome.totem # --- # Video
    pkgs.gnome.eog # ----- # Photos
  ];

  # https://github.com/NixOS/nixpkgs/pull/107850
  systemd.services."display-manager".preStart =
    "cp /home/vanilla/.config/monitors.xml /run/gdm/.config/monitors.xml";
}
