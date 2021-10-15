{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Xorg
  services.xserver.enable = true;

  # Default display manager of xmonad.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.background =
    # https://github.com/NixOS/nixos-artwork/tree/master/wallpapers
    pkgs.nixos-artwork.wallpapers."nineish".gnomeFilePath;

  services.xserver.displayManager.lightdm.greeters.gtk.enable = true;
  services.xserver.displayManager.lightdm.greeters.gtk = {
    theme = { package = pkgs.layan-gtk-theme; name = "Layan-light-solid"; };
    iconTheme = { package = pkgs.tela-icon-theme; name = "Tela-pink"; };
    cursorTheme = { package = pkgs.libsForQt5.breeze-qt5; name = "breeze_cursors"; };
  };

  # https://nixos.wiki/wiki/XMonad
  services.xserver.windowManager.xmonad.enable = true;

  # https://nixos.wiki/wiki/Remote_Desktop
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "xmonad";
  networking.firewall.allowedTCPPorts = [ 3389 ];
}
