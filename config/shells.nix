{ programs, home, pkgs, ... }:
let plugin-git = pkgs.fishPlugins.buildFishPlugin rec {
  pname = "plugin-git";
  version = "bc6caff";

  src = pkgs.fetchgit {
    url = "https://github.com/jhillyerd/${pname}";
    rev = "${version}38fdcac309fddac6651c13cd217d5a382";
    sha256 = "sha256-jodMn2KfSnO6xUgOvMHYXU4PUAEUS5skVuNcBJQYzyU=";
  };
};
in
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
  '';
  programs.fish.shellAliases = { top = "bpytop"; };

  # https://github.com/franciscolourenco/done#for-linux-set-the-urgency-level-for-notifications-sent-via-notify-send-low-normal-critical-the-default-is-normal-for-regular-commands-and-critical-for-failed-commands
  # https://github.com/jhillyerd/plugin-git/blob/master/hooks/install.fish
  programs.fish.interactiveShellInit = ''
    set -U __done_notification_urgency_level low
    set -U __done_notification_urgency_level_failure normal
    source ${plugin-git}/share/fish/vendor_functions.d/__git.init.fish && __git.init
    set -e LD_LIBRARY_PATH
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
  ] ++ (with pkgs.fishPlugins; [ done pisces bfish ]);

  programs.fish.plugins = [
    {
      name = "plugin-bang-bang";
      src = pkgs.fetchgit {
        url = "https://github.com/oh-my-fish/plugin-bang-bang";
        rev = "f969c618301163273d0a03d002614d9a81952c1e";
        sha256 = "sha256-A8ydBX4LORk+nutjHurqNNWFmW6LIiBPQcxS3x4nbeQ=";
      };
    }
    {
      name = "replay.fish";
      src = pkgs.fetchgit {
        url = "https://github.com/jorgebucaran/replay.fish";
        rev = "1.2.0";
        sha256 = "sha256-Q/9YVdiRSJw1SdcfQv2h7Lj6EyFustRk+kmh1eRRQ6k=";
      };
    }
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
