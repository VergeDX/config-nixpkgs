{ stdenv, fetchgit, gtk3, ... }:
stdenv.mkDerivation rec {
  pname = "Fluent-icon-theme";
  version = "2021-12-20";

  src = fetchgit {
    url = "https://github.com/vinceliuice/${pname}";
    rev = "${version}";
    hash = "sha256-EgQEGWPtNMDATuFbFQr8mHKqmCD+0b4uY35JNWSQ6Mg=";
  };

  nativeBuildInputs = [ gtk3 ];
  installPhase = ''
    patchShebangs ./install.sh
    $_ -d $out/share/icons
  '';
}
