{ stdenv, fetchgit, cmake, ... }:
stdenv.mkDerivation rec {
  pname = "libcron";
  version = "1.3.0";

  src = fetchgit {
    url = "https://github.com/PerMalmberg/${pname}";
    rev = "v${version}";
    hash = "sha256-MXmEHUJOZNnbJNMfhDKvl6fwVvPG3MjCaER0xOwRX2I=";
  };

  nativeBuildInputs = [ cmake ];

  # https://github.com/tindy2013/subconverter/blob/v0.7.1/scripts/build.alpine.release.sh#L34
  installPhase = ''
    mkdir -p $out/lib/ $out/include/libcron/ $out/include/date/
    install -m644 /build/libcron/libcron/out/Release/liblibcron.a $out/lib/
    install -m644 /build/libcron/libcron/include/libcron/* $out/include/libcron/
    install -m644 /build/libcron/libcron/externals/date/include/date/* $out/include/date/
  '';
}
