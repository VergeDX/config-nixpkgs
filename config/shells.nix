{ programs, home, pkgs, ... }:
{
  programs.fish.enable = true;
  # https://starship.rs/zh-CN/config/#%E6%8F%90%E7%A4%BA%E7%AC%A6
  # programs.starship.enable = true;
  # programs.starship.settings = {
  #   add_newline = false;
  #   line_break = { disabled = true; };
  # };

  # https://github.com/nvbn/thefuck/wiki/Shell-aliases#fish
  programs.fish.shellInit = "thefuck --alias | source";
  programs.fish.shellAliases = { top = "bpytop"; };
  home.packages = [
    pkgs.thefuck

    pkgs.powerline-go
    pkgs.powerline-rs

    pkgs.starship
    pkgs.nur.repos.ilya-fedin.silver

    pkgs.nushell
  ] ++ [
    pkgs.powerline-fonts
    pkgs.powerline
    pkgs.powerline-symbols
    pkgs.meslo-lgs-nf
  ];

  programs.fish.plugins = [
    {
      name = "done";
      src = pkgs.fetchgit {
        url = "https://github.com/franciscolourenco/done";
        rev = "1.16.3";
        sha256 = "sha256-Xld66z9vVp3kxikndZ9k/zlNvP0YSoSCNTBkJ8rT3uo=";
      };
    }
    {
      name = "pisces";
      src = pkgs.fetchgit {
        url = "https://github.com/laughedelic/pisces";
        rev = "v0.7.0";
        sha256 = "sha256-Oou2IeNNAqR00ZT3bss/DbhrJjGeMsn9dBBYhgdafBw=";
      };
    }
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
    {
      name = "fish";
      src = pkgs.fetchgit {
        url = "https://github.com/silver-prompt/fish";
        rev = "c1a31f16a2739998241e181c8f453999321b4c67";
        sha256 = "sha256-hzCn760N4+NZDjtLj+0ZoO0IgV61yOzRAHvj2MQOqd4=";
      };
    }
  ];

  # https://github.com/reujab/silver/tree/v2.0.0#configuration
  home.file.".config/silver/silver.toml".text = ''
    [[left]]
    name = "dir"
    color.background = "blue"
    color.foreground = "black"

    [[left]]
    name = "git"
    color.background = "green"
    color.foreground = "black"

    [[right]]
    name = "status"
    color.background = "white"
    color.foreground = "black"

    [[right]]
    name = "cmdtime"
    color.background = "magenta"
    color.foreground = "black"

    [[right]]
    name = "shell"
    color.background = "green"
    color.foreground = "black"
  '';

  programs.fish.functions = {
    nixos-update = {
      body = ''
        nix-channel --update
        cd ~/.config/nixpkgs/
        git reset && nix flake update
        unlink ~/.config/gtk-3.0/gtk.css && home-manager switch
        git reset && rm flake.lock && true

        sudo nix-channel --update
        sudo nixos-rebuild switch && cd
      '';
    };
  };

  # https://github.com/nix-community/home-manager/issues/1338
  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableSyntaxHighlighting = true;
  programs.zsh.initExtra = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  # https://github.com/nix-community/home-manager/blob/master/modules/home-environment.nix#L230
  home.sessionVariables = { POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = true; };

  # https://github.com/wting/autojump
  programs.autojump.enable = true;
}
