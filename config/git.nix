{ pkgs, programs, ... }:
let gitalias = (pkgs.callPackage ../packages/resources/gitalias.nix) { };
in
{
  # https://github.com/nix-community/home-manager#keeping-your--safe-from-harm
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  # https://github.com/dandavison/delta
  # programs.git.delta.enable = true;

  programs.git.userName = "Vanilla";
  programs.git.userEmail = "neko@hydev.org";
  # https://github.com/GitAlias/gitalias#install-with-typical-usage
  programs.git.includes = [{ path = "${gitalias}/${gitalias.fileName}"; }];

  # https://nixos.wiki/wiki/Git
  programs.git.extraConfig = {
    pack = {
      windowMemory = "2g";
      packSizeLimit = "1g";
    };
  };

  # https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix#L163
  # http://cms-sw.github.io/tutorial-proxy.html
  programs.git.extraConfig = {
    http.proxy = "socks5://localhost:1089";
    core.editor = "nvim";

    # https://github.com/so-fancy/diff-so-fancy#usage
    # core.pager = "diff-so-fancy | less --tabs=4 -RFX";
    # interactive.diffFilter = "diff-so-fancy --patch";
  };

  home.packages = [ pkgs.diff-so-fancy ];

  # https://gist.github.com/coin8086/7228b177221f6db913933021ac33bb92
  programs.ssh.enable = true;
  programs.ssh.matchBlocks."git@github.com" = {
    host = "github.com";
    user = "git";
    proxyCommand = "nc -X connect -x localhost:8889 %h %p";
  };
}
