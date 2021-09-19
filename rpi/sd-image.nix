{ pkgs, ... }:
{
  imports = [
    # https://nixos.wiki/wiki/NixOS_on_ARM#Build_your_own_image
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];

  # https://github.com/NixOS/nixpkgs/issues/135828
  hardware.deviceTree.overlays = [
    {
      # https://github.com/NixOS/nixpkgs/issues/135828#issuecomment-918359063
      name = "issuecomment-918359063";
      dtsText = ''
        // SPDX-License-Identifier: GPL-2.0
        /dts-v1/;
        /plugin/;
        / {
            compatible = "brcm,bcm2711";
            fragment@1 {
                target = <&emmc2bus>;
                __overlay__ {
                    dma-ranges = <0x00 0x00 0x00 0x00 0xfc000000>;
                };
            };
        };
      '';
    }
  ];

  ## Build
  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # nix-build '<nixpkgs/nixos>' -A config.system.build.sdImage -I nixos-config=./sd-image.nix
  # --argstr system aarch64-linux

  ## Install
  # https://www.raspberrypi.org/documentation/computers/getting-started.html#installing-images-on-linux
  # sudo dd += bs=4M conv=fsync status=progress
}
