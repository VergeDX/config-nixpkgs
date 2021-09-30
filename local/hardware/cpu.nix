{ lib, ... }:
{
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # https://discourse.nixos.org/t/update-microcode-microcodeintel-not-working/10856
  hardware.cpu.amd.updateMicrocode = true;
  hardware.cpu.intel.updateMicrocode = true;
}
