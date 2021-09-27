{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/XMonad
  # services.xserver.enable = true;
  # services.xserver.windowManager.xmonad.enable = true;

  environment.systemPackages = with pkgs; [ xmonad-with-packages xterm ];

  # https://nixos.wiki/wiki/Remote_Desktop
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "xmonad";
  networking.firewall.allowedTCPPorts = [ 3389 ];
}