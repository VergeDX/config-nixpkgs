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
}
