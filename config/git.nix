{ pkgs, programs, ... }:
let gitalias = (pkgs.callPackage ../packages/resources/gitalias.nix) { };
in
{
  # https://github.com/nix-community/home-manager#keeping-your--safe-from-harm
  programs.git.enable = true;
  programs.git.lfs.enable = true;

  programs.git.userName = "Vanilla";
  programs.git.userEmail = "osu_Vanilla@126.com";
  # https://github.com/GitAlias/gitalias#install-with-typical-usage
  programs.git.includes = [{ path = "${gitalias}/${gitalias.fileName}"; }];

  # https://nixos.wiki/wiki/Git
  programs.git.extraConfig = {
    init.defaultBranch = "master";
    pull.rebase = "false";
    pack = {
      windowMemory = "2g";
      packSizeLimit = "1g";
    };
  };

  # https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix#L163
  # http://cms-sw.github.io/tutorial-proxy.html
  programs.git.extraConfig = {
    http.proxy = "socks5://127.0.0.1:7890";
    core.editor = "nvim";
  };

  home.packages = [ pkgs.diff-so-fancy ];

  # https://gist.github.com/coin8086/7228b177221f6db913933021ac33bb92
  programs.ssh.enable = true;
  programs.ssh.compression = true;
  programs.ssh.matchBlocks."git@github.com" = {
    host = "github.com";
    user = "git";
    proxyCommand = "nc -X connect -x localhost:7890 %h %p";
  };

  # https://superuser.com/questions/954509/what-are-the-correct-permissions-for-the-gnupg-enclosing-folder-gpg-warning
  programs.gpg.enable = true;
  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryFlavor = "curses";
  services.gpg-agent.enableSshSupport = true;

  # https://github.com/Yubico/yubico-piv-tool/issues/102#issuecomment-303239922
  programs.fish.interactiveShellInit = ''
    # https://unix.stackexchange.com/questions/109979/how-to-asynchronously-launch-external-program-from-cli-and-discard-its-output
    gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1 &
  '';

  # https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification/telling-git-about-your-signing-key
  programs.git.signing.key = "3750028ED04FA42E";
  programs.git.signing.signByDefault = true;
}
