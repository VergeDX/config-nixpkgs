{ stdenv, fetchurl, ... }:
stdenv.mkDerivation {
  pname = "p7zip-old";
  version = "16.02";

  src = fetchurl {
    url = "https://jaist.dl.sourceforge.net/project/p7zip/p7zip/16.02/p7zip_16.02_src_all.tar.bz2";
    hash = "sha256-XrIKwOKUT2y5wtUd1sRRiUHBhTR9QInqiQh//dbiNB8=";
  };

  patches = [
    (fetchurl {
      url = "https://src.fedoraproject.org/rpms/p7zip/raw/rawhide/f/gcc10-conversion.patch";
      hash = "sha256-+QAT1m08mGXLVv7S+wQyBXoHKD1TYeKunpjD02V/QqE=";
    })
    (fetchurl {
      url = "https://sourceforge.net/p/p7zip/patches/35/attachment/diff.patch";
      hash = "sha256-Utg02wKrKwtE4WUMa2MlhWytps0N254QmQHhI5n/V7w=";
    })
  ];

  # NixOS - nixpkgs: pkgs/tools/archivers/p7zip/default.nix
  makeFlags = [ "DEST_HOME=${placeholder "out"}" ];
}
