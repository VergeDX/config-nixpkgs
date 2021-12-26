{ pkgs, ... }:
let bash-wakatime-sh = pkgs.fetchurl {
  url = "https://raw.githubusercontent.com/irondoge/bash-wakatime/master/bash-wakatime.sh";
  hash = "sha256-JeG8eO6UnDXfVHMFH1+Hzss5tg4xvmN81oiSohvzNxk=";
}; in
{
  # https://nix-community.github.io/home-manager/options.html#opt-programs.bash.enable
  programs.bash.enable = true;

  # https://wakatime.com/terminal#install-bash
  # https://nix-community.github.io/home-manager/options.html#opt-programs.bash.bashrcExtra
  programs.bash.bashrcExtra = "source ${bash-wakatime-sh}";

  # https://nix-community.github.io/home-manager/options.html#opt-programs.starship.enableBashIntegration
  programs.starship.enableBashIntegration = false;
}
