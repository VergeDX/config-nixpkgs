{ ... }:
{
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
}
