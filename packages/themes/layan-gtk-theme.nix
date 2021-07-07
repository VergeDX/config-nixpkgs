{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  pname = "layan-gtk-theme";
  version = "2021-06-30";

  src = fetchgit {
    url = "https://github.com/vinceliuice/Layan-gtk-theme";
    rev = version;
    sha256 = "sha256-FI8+AJlcPHGOzxN6HUKLtPGLe8JTfTQ9Az9NsvVUK7g=";
  };

  # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/data/themes/vimix/default.nix#L26
  installPhase = ''
    patchShebangs .
    mkdir -p $out/share/themes
    name= ./install.sh -d $out/share/themes
    rm $out/share/themes/*/{AUTHORS,LICENSE}
  '';
}
