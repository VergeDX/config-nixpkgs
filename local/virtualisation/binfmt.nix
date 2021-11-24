{ pkgs, ... }:
{
  boot.binfmt.emulatedSystems =
    [ "aarch64-linux" "riscv64-linux" "x86_64-windows" ];
}
