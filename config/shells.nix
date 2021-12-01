{ programs, home, pkgs, ... }:
{
  programs.fish.enable = true;
  # https://starship.rs/zh-CN/config/#%E6%8F%90%E7%A4%BA%E7%AC%A6
  programs.starship.enable = true;
  programs.starship.settings = { add_newline = false; line_break = { disabled = true; }; };

  # https://github.com/nvbn/thefuck/wiki/Shell-aliases#fish
  # https://github.com/haslersn/any-nix-shell#fish
  programs.fish.shellInit = ''
    ${pkgs.thefuck}/bin/thefuck --alias | source
    ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
  '' + "rose_pine dawn > /dev/null";

  # https://github.com/rose-pine/fish#usage
  home.file.".config/fish/functions/rose_pine.fish".source =
    "${pkgs.callPackage ../packages/resources/rose-pine-fish.nix { }}/rose_pine.fish";

  programs.fish.shellAliases = { top = "bpytop"; };

  # https://github.com/franciscolourenco/done#for-linux-set-the-urgency-level-for-notifications-sent-via-notify-send-low-normal-critical-the-default-is-normal-for-regular-commands-and-critical-for-failed-commands
  programs.fish.interactiveShellInit = ''
    set -U __done_notification_urgency_level low
    set -U __done_notification_urgency_level_failure normal
  '';

  home.packages = [
    pkgs.powerline-go
    pkgs.powerline-rs

    pkgs.starship
    pkgs.nur.repos.ilya-fedin.silver
  ] ++ [
    pkgs.powerline-fonts
    pkgs.powerline
    pkgs.powerline-symbols
    pkgs.meslo-lgs-nf

    pkgs.bubblewrap
  ] ++ (with pkgs.fishPlugins; [ done pisces bfish ])
  ++ [
    pkgs.nur.repos.linyinfeng.fishPlugins.git
    pkgs.nur.repos.linyinfeng.fishPlugins.bang-bang
    pkgs.nur.repos.linyinfeng.fishPlugins.replay
  ];

  programs.fish.plugins = [
    {
      name = "nix-completions.fish";
      src = pkgs.fetchgit {
        url = "https://github.com/kidonng/nix-completions.fish";
        rev = "dcb15c4f7d3e85d8f7cd3eb09b3014ccd278aab8";
        sha256 = "sha256-3HHcaX2yVZXrRjOeSlI8tPhSjRR2tPU6AWq6eU5nPOs=";
      };
    }
  ];

  # https://github.com/wting/autojump
  programs.autojump.enable = true;
}
