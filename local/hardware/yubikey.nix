{ pkgs, inputs, system, ... }:
let pkgsUnstable = (import inputs.nixpkgs-unstable { inherit system; }); in
{
  # https://nixos.wiki/wiki/Yubikey
  security.pam.yubico.enable = true;

  programs.gnupg.agent.pinentryFlavor = "curses";
  environment.shellInit = ''
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  '';

  # security.pam.yubico.debug = true;
  security.pam.yubico.mode = "challenge-response";
  security.pam.yubico.control = "required";

  # https://nixos.wiki/wiki/Yubikey
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # https://github.com/NixOS/nixpkgs/pull/148601
  services.pcscd.enable = true;
  nixpkgs.overlays = [ (self: super: { pcsclite = pkgsUnstable.pcsclite; }) ];
}
