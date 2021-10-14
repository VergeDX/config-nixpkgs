{ ... }:
# https://docs.nixbuild.net/getting-started/#quick-nixos-configuration
{
  programs.ssh.extraConfig = ''
    Host eu.nixbuild.net
      PubkeyAcceptedKeyTypes ssh-ed25519
      IdentityFile /home/vanilla/.ssh/id_ed25519
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
        system = "aarch64-linux";
        maxJobs = 100;
        supportedFeatures = [ "big-parallel" "benchmark" ];
      }
    ];
  };
}
