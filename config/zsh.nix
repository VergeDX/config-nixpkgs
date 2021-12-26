{ pkgs, ... }:
let wakatime = pkgs.python3Packages.callPackage ../packages/python3/wakatime.nix { }; in
{
  programs.zsh.enable = true;

  # https://nix-community.github.io/home-manager/options.html#opt-programs.zsh.enable
  programs.zsh = {
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
  };

  # https://nix-community.github.io/home-manager/options.html#opt-programs.zsh.autocd
  programs.zsh.autocd = true;

  # https://nix-community.github.io/home-manager/options.html#opt-programs.zsh.oh-my-zsh
  programs.zsh.oh-my-zsh.enable = true;
  # https://nix-community.github.io/home-manager/options.html#opt-programs.zsh.prezto
  programs.zsh.prezto.enable = true;

  # https://nix-community.github.io/home-manager/options.html#opt-programs.starship.enable
  programs.starship.enableZshIntegration = false;

  # https://wakatime.com/terminal#install-zsh
  programs.zsh.plugins = [
    rec {
      name = "wakatime-zsh-plugin";
      # https://nix-community.github.io/home-manager/options.html#opt-programs.zsh.plugins
      file = "wakatime.plugin.zsh";
      src = pkgs.fetchgit {
        url = "https://github.com/sobolevn/${name}";
        hash = "sha256-YDfbbugRXmfC4NVXSvSP4Fhm92t0KJKcoFnfWj4CWN0=";
      };
    }
  ];

  # https://nix-community.github.io/home-manager/options.html#opt-programs.zsh.sessionVariables
  programs.zsh.sessionVariables = {
    "ZSH_WAKATIME_BIN" = "${wakatime}/bin/wakatime";
  };
}
