{ pkgs, ... }:
let ASF-Akisamu = {
  "Enabled" = true;
  "SteamLogin" = "@SteamLogin@";
  "SteamPassword" = "@SteamPassword@";
};
in
{
  programs.htop.enable = true;
  home.packages = with pkgs; [ dig tcpdump ]
    ++ [ speedtest-cli ArchiSteamFarm ];

  home.activation."ASF-Akisamu.json" = with builtins; ''
    mkdir -p ~/.config/asf/config/ && cd ~/.config/asf/config/
    rm -f Akisamu.json && true && echo '${toJSON ASF-Akisamu}' > Akisamu.json

    SteamLogin="$(cat /run/secrets/asf/SteamLogin)"
    SteamPassword="$(cat /run/secrets/asf/SteamPassword)"

    sed -i "s/@SteamLogin@/$SteamLogin/g" Akisamu.json
    sed -i "s/@SteamPassword@/$SteamPassword/g" Akisamu.json

    chmod u-w Akisamu.json && cd ~
  '';
}
