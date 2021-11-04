{ pkgs, ... }:
# https://docs.nixbuild.net/getting-started/#quick-nixos-configuration
{
  # https://superuser.com/questions/454210/how-can-i-use-ssh-with-a-socks-5-proxy
  programs.ssh.extraConfig = ''
    Host eu.nixbuild.net
      PubkeyAcceptedKeyTypes ssh-ed25519
      IdentityFile /home/vanilla/.ssh/id_ed25519
      ProxyCommand ${pkgs.netcat}/bin/nc -X 5 -x 127.0.0.1:1089 %h %p
  '';

  programs.ssh.knownHosts = {
    nixbuild = {
      hostNames = [ "eu.nixbuild.net" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
    };
  };

  nix = {
    distributedBuilds = true;

    # https://docs.nixbuild.net/getting-started/#aarch64-linux-builds
    buildMachines = [
      {
        hostName = "eu.nixbuild.net";

        # system = "aarch64-linux";
        # system = "x86_64-linux";
        # systems = [ "aarch64-linux" "x86_64-linux" ];

        maxJobs = 100;
        supportedFeatures = [ "big-parallel" "benchmark" ];
      }
    ];
  };
}
