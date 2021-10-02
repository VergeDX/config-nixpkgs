{ pkgs, ... }:
let qemu-efi-aarch64 = pkgs.callPackage ./qemu-efi-aarch64.nix { };
in
{
  # https://nixos.wiki/wiki/Podman
  virtualisation.podman.enable = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # https://docs.hercules-ci.com/arion/#_nixos
  environment.systemPackages = with pkgs; [ arion docker-client ];
  virtualisation.podman.dockerSocket.enable = true;
  virtualisation.podman.defaultNetwork.dnsname.enable = true;
  users.extraUsers."vanilla".extraGroups = [ "podman" ];

  # https://nixos.wiki/wiki/Virt-manager
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemuOvmf = false;
  virtualisation.libvirtd.qemuVerbatimConfig = ''
    nvram = [ "${qemu-efi-aarch64}/usr/share/AAVMF/AAVMF_CODE.fd:${qemu-efi-aarch64}/usr/share/AAVMF/AAVMF_VARS.fd" ]
  '';

  # https://nixos.wiki/wiki/Virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "vanilla" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
