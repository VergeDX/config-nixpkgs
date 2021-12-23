{ stdenv, fetchgit, ... }:
stdenv.mkDerivation rec {
  pname = "Fluent-gtk-theme";
  version = "2021-12-20";

  src = fetchgit {
    url = "https://github.com/vinceliuice/${pname}";
    rev = "${version}";
    hash = "sha256-qcKENFyT4w1Tl2K0wUYVdR3qaiSE75DiadWTSG4rotE=";
  };

  installPhase = ''
    patchShebangs ./install.sh
    $_ -d $out/share/themes
  '';
}
