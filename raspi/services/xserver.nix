{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Xorg
  services.xserver.enable = true;

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    vaapiVdpau
    libvdpau-va-gl
  ];

  # https://nixos.wiki/wiki/XMonad
  services.xserver.windowManager.xmonad.enable = true;

  # https://nixos.wiki/wiki/Remote_Desktop
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "xmonad";
  networking.firewall.allowedTCPPorts = [ 3389 ];
}
