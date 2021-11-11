{ pkgs, ... }:
{
  programs.htop.enable = true;
  home.packages = with pkgs; [ dig tcpdump ]
    ++ [ speedtest-cli ];
}
