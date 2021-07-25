{ programs, home, pkgs, ... }:
{
  # https://github.com/NickCao/flakes/blob/master/nixos/local/configuration.nix#L246
  programs.chromium.enable = true; # AdGuard
  programs.chromium.extensions = [ "bgnkhhnnamicmpeenaelnjfhikgbkllg" ];

  programs.firefox.enable = true;
  programs.firefox.extensions = [
    pkgs.nur.repos.rycee.firefox-addons.bitwarden
  ];

  home.packages = [ pkgs.google-chrome ];
}
