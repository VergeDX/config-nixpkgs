{ pkgs, programs, ... }:
let gitalias = (pkgs.callPackage ../packages/resources/gitalias.nix) { };
in
{
  # https://github.com/nix-community/home-manager#keeping-your--safe-from-harm
  programs.git.enable = true;
  programs.git.lfs.enable = true;

  programs.git.userName = "Vanilla";
  programs.git.userEmail = "neko@hydev.org";

  # https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix#L163
  # http://cms-sw.github.io/tutorial-proxy.html
  programs.git.extraConfig = {
    http.proxy = "socks5://localhost:1089";
    # https://github.com/GitAlias/gitalias#install-with-typical-usage
    include.path = "${gitalias.out}/${gitalias.fileName}";
  };
}
