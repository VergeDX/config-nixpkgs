{ stdenv, fetchFromGitHub, openssl, capstone, keystone, rapidjson }:
stdenv.mkDerivation rec {
  pname = "navicat-keygen-tools";
  version = "20200226";

  src = fetchFromGitHub {
    owner = "HeQuanX";
    repo = "navicat-keygen-tools";
    rev = "${version}";
    sha256 = "sha256:11zbnlky2zvldq6kf7qmc69qwhhwcjg4gz72w7ka7a0kz1wymla6";
  };

  # https://github.com/HeQuanX/navicat-keygen-tools/blob/main/doc/how-to-build.md#1-prerequisites
  buildInputs = [ openssl capstone keystone rapidjson ];
  buildPhase = "make all";
  # https://nixos.org/manual/nixpkgs/stable/#ssec-controlling-phases
  installPhase = "mkdir -p $out/bin && cp -r bin/* $out/bin";
}
