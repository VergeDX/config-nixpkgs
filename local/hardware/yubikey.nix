{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Yubikey
  security.pam.yubico.enable = true;

  # https://nixos.wiki/wiki/Yubikey#GPG_and_SSH
  programs.ssh.startAgent = false;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.gnupg.agent.pinentryFlavor = "curses";
  environment.shellInit = ''
    export GPG_TTY="$(tty)"
    # https://github.com/Yubico/yubico-piv-tool/issues/102#issuecomment-303239922
    gpg-connect-agent updatestartuptty /bye
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  '';

  # security.pam.yubico.debug = true;
  security.pam.yubico.mode = "challenge-response";
  security.pam.yubico.control = "required";

  # https://nixos.wiki/wiki/Yubikey
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
}
