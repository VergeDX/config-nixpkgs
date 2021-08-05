{ programs, home, pkgs, buildFirefoxXpiAddon, ... }:
let
  adguard_adblocker = (pkgs.fetchFirefoxAddon rec {
    name = "adguard_adblocker";
    url = "https://addons.mozilla.org/firefox/downloads/file/3782305/${name}-3.6.6-an+fx.xpi";
    sha256 = "sha256-/lPWlibJV747bf4Ctmtl4MegRp/p+Raahn97bHdT5Oo=";
  });
  proxy_switchyomega = (pkgs.fetchFirefoxAddon rec {
    name = "proxy_switchyomega";
    url = "https://addons.mozilla.org/firefox/downloads/file/1056777/${name}-2.5.20-an+fx.xpi";
    sha256 = "sha256-Ng2mH5CKAKGQAkHt4g+KP4JnWyNlz984bvo1+yhMyjg=";
  });
in
{
  # https://github.com/NickCao/flakes/blob/master/nixos/local/configuration.nix#L246
  programs.chromium.enable = true;
  # https://github.com/nix-community/home-manager/issues/2216
  # programs.chromium.package = pkgs.ungoogled-chromium;
  programs.chromium.extensions = [
    # https://chrome.google.com/webstore/category/extensions
    "bgnkhhnnamicmpeenaelnjfhikgbkllg" # AdGuard
    "fngmhnnpilhplaeedifhccceomclgfbg" # EditThisCookie
  ];

  programs.firefox.enable = true;
  programs.firefox.extensions = [
    adguard_adblocker
    pkgs.nur.repos.rycee.firefox-addons.bitwarden
    proxy_switchyomega
  ];

  home.packages = [ pkgs.google-chrome ];
}
