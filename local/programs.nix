{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  programs.thefuck.enable = true;

  # https://nixos.wiki/wiki/Android
  programs.adb.enable = true;
  users.users."vanilla".extraGroups = [ "adbusers" ];
  services.udev.packages = [ pkgs.android-udev-rules ];

  programs.proxychains.enable = true;
  programs.proxychains.proxies."myproxy" = { type = "socks5"; host = "127.0.0.1"; port = 1089; };
  programs.proxychains.proxies."myproxy".enable = true;

  # https://nixos.wiki/wiki/Steam#Normal_install
  programs.steam.enable = true;
  # https://nixos.wiki/wiki/Steam#Adding_missing_dependencies
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override { extraPkgs = pkgs: [ pkgs.icu ]; };
  };

  # https://www.markjour.com/article/20190506-unzip-chinese.html#toc-8
  environment.variables = { UNZIP = "-O CP936"; ZIPINFO = "-O CP936"; };
}
