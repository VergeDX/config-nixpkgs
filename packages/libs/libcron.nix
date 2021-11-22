{ stdenv, fetchgit, cmake, ... }:
stdenv.mkDerivation rec {
  pname = "libcron";
  version = "1.3.0";

  src = fetchgit {
    url = "https://github.com/PerMalmberg/${pname}";
    rev = "v${version}";
    hash = "sha256-MXmEHUJOZNnbJNMfhDKvl6fwVvPG3MjCaER0xOwRX2I=";
  };

  # https://github.com/PerMalmberg/libcron/pull/23/files
  patchPhase = ''
    echo 'install(TARGETS libcron DESTINATION lib)' >> CMakeLists.txt
    echo 'install(DIRECTORY libcron/include/libcron DESTINATION include)' >> CMakeLists.txt
    echo 'install(DIRECTORY libcron/externals/date/include/date DESTINATION include)' >> CMakeLists.txt
  '';

  nativeBuildInputs = [ cmake ];
}
