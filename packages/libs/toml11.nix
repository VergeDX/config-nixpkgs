{ stdenv, fetchgit, cmake, ... }:
stdenv.mkDerivation rec {
  pname = "toml11";
  version = "3.7.0";

  src = fetchgit {
    url = "https://github.com/ToruNiina/${pname}";
    rev = "v${version}";
    hash = "sha256-oPxKrm0d2lQiSLUW9bFV8n8kF9J9SOCOGl4VGfQANYI=";
  };

  nativeBuildInputs = [ cmake ];
}
