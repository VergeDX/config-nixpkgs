{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ./disks.nix
    ./cpu.nix
    ./bluetooth.nix
    ./nvidia.nix
    ./steam.nix
    ./yubikey.nix
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  # boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows
  time.hardwareClockInLocalTime = true;

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  nixpkgs.config.packageOverrides = pkgs: { vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; }; };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver vaapiIntel vaapiVdpau libvdpau-va-gl ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel ];
  };
}
