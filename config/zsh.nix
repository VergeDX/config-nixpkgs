{ programs, pkgs, home, ... }:
{
  # https://github.com/nix-community/home-manager/issues/1338
  programs.zsh.enable = true;
  programs.zsh.initExtra = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

  # https://github.com/nix-community/home-manager/blob/master/modules/home-environment.nix#L230
  home.sessionVariables = {
    POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = true;
  };

  home.packages = [ pkgs.meslo-lgs-nf ];
}
