{ pkgs, ... }:
let nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
  export __NV_PRIME_RENDER_OFFLOAD=1
  export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  export __GLX_VENDOR_LIBRARY_NAME=nvidia
  export __VK_LAYER_NV_optimus=NVIDIA_only
  exec -a "$0" "$@"
'';
in
{
  # https://nixos.wiki/wiki/Nvidia#offload_mode
  environment.systemPackages = [ nvidia-offload ];
  nixpkgs.config.allowUnfree = true;

  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L104
  hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.nvidiaSettings = false;

  hardware.nvidia.prime.offload.enable = true;
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";

  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = true;

  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L160
  services.xserver.videoDrivers = [ "nvidia" ];

  # https://wiki.archlinux.org/title/Kernel_mode_setting#Early_KMS_start
  boot.initrd.enable = true;
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  # https://wiki.archlinux.org/title/PRIME#When_an_application_is_rendered_with_the_discrete_card,_it_only_renders_a_black_screen
  services.xserver.config = ''
    Section "Device"
        Identifier "Intel Graphics"
        Driver "intel"
        Option "DRI" "3"
    EndSection
  '';
}
