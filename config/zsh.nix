{ ... }:
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

  # https://nix-community.github.io/home-manager/options.html#opt-programs.starship.enable
  programs.starship.enableZshIntegration = false;
}
