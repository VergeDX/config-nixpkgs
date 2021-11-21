{ pkgs, ... }:
{
  boot.binfmt.emulatedSystems =
    [ "aarch64-linux" "riscv64-linux" ];
}
