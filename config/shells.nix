{ programs, home, pkgs, ... }:
{
  programs.fish.enable = true;
  programs.fish.promptInit = ''
    function fish_prompt
        # https://github.com/justjanne/powerline-go#fish
        eval ${pkgs.powerline-go}/bin/powerline-go -error $status -jobs (jobs -p | wc -l)
    end
  '';

  home.packages = [
    pkgs.powerline
    pkgs.powerline-go
    pkgs.powerline-fonts
    pkgs.powerline-symbols
    pkgs.powerline-rs

    pkgs.starship
    pkgs.nur.repos.ilya-fedin.silver

    pkgs.meslo-lgs-nf
    pkgs.nushell
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
      name = "tide";
      src = pkgs.fetchgit {
        url = "https://github.com/IlanCosman/tide";
        rev = "v4.3.4";
        sha256 = "sha256-XTpkjQOdFXBO9NlEwOMX26bbuxojVmdtxDcfLKXFUdE=";
      };
    }
    {
      name = "nix-completions.fish";
      src = pkgs.fetchgit {
        url = "https://github.com/kidonng/nix-completions.fish";
        rev = "eacfeb1e537052f05c5a867cb39f84ac2adf267f";
        sha256 = "sha256-6kj9c0eOU9pa8vwuz1ce4z7jgrCkNTm1pbs3AiZNbPY=";
      };
    }
  ];

  # https://github.com/nix-community/home-manager/issues/1338
  programs.zsh.enable = true;
  programs.zsh.initExtra = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  # https://github.com/nix-community/home-manager/blob/master/modules/home-environment.nix#L230
  home.sessionVariables = { POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = true; };

  # https://github.com/wting/autojump
  programs.autojump.enable = true;
}
