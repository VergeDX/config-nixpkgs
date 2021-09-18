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

  # https://wiki.archlinux.org/title/Chromium_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
  # https://gist.github.com/foutrelis/14e339596b89813aa9c37fd1b4e5d9d5
  systemd.user.sessionVariables = {
    GOOGLE_DEFAULT_CLIENT_ID = "77185425430.apps.googleusercontent.com";
    GOOGLE_DEFAULT_CLIENT_SECRET = "OTJgUOQcT7lO7GsGZq2G4IlT";
  };
}
