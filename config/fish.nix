{ programs, home, pkgs, ... }:
let silver = pkgs.callPackage ../packages/resources/silver.nix { };
in
{
  programs.fish.enable = true;
  # programs.fish.shellInit = "starship init fish | source";

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
        rev = "1.16.2";
        sha256 = "sha256-W3Xw5878ixzEaFCtxCqfDu5kxOYUwdENdC+cBvwAwSE=";
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
      name = "fish";
      src = pkgs.fetchgit {
        url = "https://github.com/silver-prompt/fish";
        rev = "c1a31f16a2739998241e181c8f453999321b4c67";
        sha256 = "sha256-hzCn760N4+NZDjtLj+0ZoO0IgV61yOzRAHvj2MQOqd4=";
      };
    }
  ];

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
}
