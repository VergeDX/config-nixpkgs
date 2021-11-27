{ callPackage, ... }:
{
  calculator = callPackage ./calculator.nix { };
  dock = callPackage ./dock.nix { };
  filemanager = callPackage ./filemanager.nix { };
  fishui = callPackage ./fishui.nix { };
  launcher = callPackage ./launcher.nix { };
  libcutefish = callPackage ./libcutefish.nix { };
  terminal = callPackage ./terminal.nix { };
}
