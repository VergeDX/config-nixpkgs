{ pkgs, ... }:
{
  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L133
  services.fstrim.enable = true;

  environment.systemPackages = with pkgs; [ xmonad-with-packages xterm ];
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "xmonad";
}
