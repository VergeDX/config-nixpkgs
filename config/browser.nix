{ programs, home, pkgs, ... }:
{
  # https://github.com/NickCao/flakes/blob/master/nixos/local/configuration.nix#L246
  programs.chromium.enable = true; # AdGuard
  programs.chromium.extensions = [ "bgnkhhnnamicmpeenaelnjfhikgbkllg" ];

  home.sessionVariables = { CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable"; };

  home.packages = [
    pkgs.firefox
    pkgs.google-chrome
  ];
}
