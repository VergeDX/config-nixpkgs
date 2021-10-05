{ stdenv, fetchFromGitHub, cmake, ... }:
stdenv.mkDerivation rec {
  name = "colorized-logs";
  version = "2.6";

  src = fetchFromGitHub {
    owner = "kilobyte";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-QiZeIYeIWA3C7wYi2G2EItdW+jLjVrCbIYllur/RtY8=";
  };

  nativeBuildInputs = [ cmake ];
}
