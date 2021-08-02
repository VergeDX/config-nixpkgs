{ stdenv, fetchFromGitHub, cmake, ... }:
stdenv.mkDerivation rec {
  name = "colorized-logs";
  version = "2.5";

  src = fetchFromGitHub {
    owner = "kilobyte";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-5pfQrd2NbPdVh/R+w3rjQAMY0s7k4VkSljtlQbfyITc=";
  };

  nativeBuildInputs = [ cmake ];
}
