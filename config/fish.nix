{ programs, powerline, pkgs, ... }:
{
  programs.fish.enable = true;
  programs.fish.shellInit = ''
    function fish_prompt
        # https://github.com/jD91mZM2/powerline-rs#fish
        powerline-rs --shell bare $status
    end
  '';

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
  ];
}
