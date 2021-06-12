{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  pname = "layan-gtk-theme";
  version = "master";

  src = fetchgit {
    url = "https://github.com/vinceliuice/Layan-gtk-theme";
    sha256 = "sha256:0b637di3ihw34gm61jh6snj0446xymmz7mf7va7vyz8ybnhqh46r";
  };

  # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/data/themes/vimix/default.nix#L26
  installPhase = ''
    patchShebangs .
    mkdir -p $out/share/themes
    name= ./install.sh -d $out/share/themes
    rm $out/share/themes/*/{AUTHORS,LICENSE}
  '';
}
