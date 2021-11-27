{ callPackage, ... }:
{
  calculator = callPackage ./calculator.nix { };
  dock = callPackage ./dock.nix { };
  filemanager = callPackage ./filemanager.nix { };
  fishui = callPackage ./fishui.nix { };
  icons = callPackage ./icons.nix { };
  launcher = callPackage ./launcher.nix { };
  libcutefish = callPackage ./libcutefish.nix { };
  screenshot = callPackage ./screenshot.nix { };
  statusbar = callPackage ./statusbar.nix { };
  terminal = callPackage ./terminal.nix { };
  wallpapers = callPackage ./wallpapers.nix { };
}
