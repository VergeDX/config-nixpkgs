{ pkgs, ... }:
let qemu-efi-aarch64 = pkgs.callPackage ./qemu-efi-aarch64.nix { };
in
{
  # https://nixos.wiki/wiki/Virt-manager
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemuOvmf = false;
  virtualisation.libvirtd.qemuVerbatimConfig = ''
    nvram = [ "${qemu-efi-aarch64}/usr/share/AAVMF/AAVMF_CODE.fd:${qemu-efi-aarch64}/usr/share/AAVMF/AAVMF_VARS.fd" ]
  '';
}
