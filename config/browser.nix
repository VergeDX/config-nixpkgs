{ programs, home, pkgs, ... }:
{
  # https://github.com/NickCao/flakes/blob/master/nixos/local/configuration.nix#L246
  programs.chromium.enable = true;
  programs.chromium.extensions = [
    # https://chrome.google.com/webstore/category/extensions
    "gighmmpiobklfepjocnamgkkbiglidom" # AdBlock
    "fngmhnnpilhplaeedifhccceomclgfbg" # EditThisCookie
  ];

  home.packages = [ pkgs.google-chrome ];
}
