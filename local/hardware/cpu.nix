{ lib, ... }:
{
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;

  # https://discourse.nixos.org/t/update-microcode-microcodeintel-not-working/10856
  hardware.cpu.amd.updateMicrocode = true;
  hardware.cpu.intel.updateMicrocode = true;
}
