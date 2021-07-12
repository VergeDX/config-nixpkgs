{ programs, home, pkgs, ... }:
let silver = pkgs.callPackage ../packages/resources/silver.nix { };
in
{
  programs.fish.enable = true;
  programs.fish.shellInit = ''
    function fish_prompt
        # https://github.com/justjanne/powerline-go#fish
        eval powerline-go -error $status -jobs (jobs -p | wc -l)
    end
  '';

  home.packages = [
    pkgs.powerline
    pkgs.powerline-go
    pkgs.powerline-fonts
    pkgs.powerline-symbols
    pkgs.powerline-rs

    pkgs.starship
    silver
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
  ];
}
