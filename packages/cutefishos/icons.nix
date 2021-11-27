{ stdenv, fetchgit, cmake, ... }:
stdenv.mkDerivation rec {
  pname = "icons";
  version = "0.5";

  src = fetchgit {
    url = "https://github.com/cutefishos/${pname}";
    rev = "${version}";
    hash = "sha256-+T2R3eo4THUCiPBBCekURTCpIMQEiNntTwyoXM/EgFU=";
  };

  nativeBuildInputs = [ cmake ];

  # https://github.com/cutefishos/icons/blob/0.5/CMakeLists.txt#L6
  patchPhase = "sed -i 's@/usr/@@g' CMakeLists.txt";
}
