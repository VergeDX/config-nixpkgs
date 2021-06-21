{ pkgs, home, ... }:
let
  peda = (pkgs.callPackage ../packages/resources/peda.nix) { };
in
{
  home.packages = [
    pkgs.nmap
    pkgs.metasploit
    (pkgs.callPackage ../packages/gui/armitage.nix { })
    pkgs.binwalk
    pkgs.gnome.ghex
    pkgs.binutils
    pkgs.exiftool
    pkgs.zsteg
    (pkgs.callPackage ../packages/gui/stegsolve.nix { })
    (pkgs.callPackage ../packages/gui/idafree.nix { })
    pkgs.gdb
    pkgs.pwntools
    pkgs.ltrace
    pkgs.bind
    pkgs.postman
    pkgs.sqlmap
  ];

  # https://github.com/longld/peda#installation
  home.file.".gdbinit".text = "source ${peda.out}/${peda.name}/peda.py";
}
