{ pkgs, config, lib, ... }:
let gnome-shell-new = pkgs: pkgs.gnome.gnome-shell.overrideAttrs (old: {
  patches = old.patches ++ lib.singleton (pkgs.fetchurl {
    url = "https://gitlab.gnome.org/GNOME/gnome-shell/-/merge_requests/1954/diffs.patch";
    hash = "sha256-qnvKaNDIzElLfFCuZLldSJloSWd/InZ9xVk8DqpPX1Y=";
  });
}); in
let gnome-settings-daemon-new = pkgs: pkgs.gnome.gnome-settings-daemon.overrideAttrs (old: {
  patches = old.patches ++ lib.singleton (pkgs.fetchurl {
    url = "https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/merge_requests/267/diffs.patch";
    hash = "sha256-/YZ1ARoK8ZHY/vuS7ZKf6desCr4ny09e/83f2YRbITg=";
  });
}); in
let gnome-control-center-new = pkgs: pkgs.gnome.gnome-control-center.overrideAttrs (old: {
  patches = old.patches ++ lib.singleton (pkgs.fetchurl {
    url = "https://gitlab.gnome.org/GNOME/gnome-control-center/-/merge_requests/1075/diffs.patch";
    hash = "sha256-nmjRJMWg8+huwLuiwgOq6kCNvDKCPnM/+Q8braZcYg4=";
  });
}); in
let mutter-new = pkgs: pkgs.gnome.mutter.overrideAttrs (old: {
  src = pkgs.fetchgit {
    url = "https://gitlab.gnome.org/YaLTeR/mutter";
    branchName = "screenshot-ui-temp";
    hash = "sha256-GaKrXObJ8T/R0NaEKbGZL8JTY0eCCNp+27vdmH7WxP8=";
  };
}); in
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # https://github.com/Ninlives/nixos-config/blob/master/world-implementation/module/hardware/gpu.nix#L63
  services.xserver.displayManager.sessionCommands =
    config.services.xserver.displayManager.setupCommands;

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

  # https://github.com/OttoAllmendinger/gnome-shell-screenshot/issues/158
  # https://copr.fedorainfracloud.org/coprs/yalter/gnome-shell-screenshot-ui/
  nixpkgs.overlays = [
    (self: super: {
      gnome = super.gnome // {
        gnome-shell = (gnome-shell-new super);
        gnome-settings-daemon = (gnome-settings-daemon-new super);
        gnome-control-center = (gnome-control-center-new super);
        mutter = (mutter-new super);
      };
    })
  ];
}
