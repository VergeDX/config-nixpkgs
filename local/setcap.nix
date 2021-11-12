{ pkgs, ... }:
{
  # NixOS - Search - "setcap"
  programs.iotop.enable = true;
  programs.iftop.enable = true;
  programs.noisetorch.enable = true;
  programs.traceroute.enable = true;
  programs.mtr.enable = true;
  programs.wavemon.enable = true;
  programs.bandwhich.enable = true;

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
}
