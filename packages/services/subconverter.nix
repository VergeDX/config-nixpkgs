{ stdenv, fetchgit, cmake, pkg-config, libevent, curl, rapidjson, callPackage, libyamlcpp, pcre2 }:
let
  toml11 = callPackage ../libs/toml11.nix { };
  quickjspp = callPackage ../libs/quickjspp.nix { };
  libcron = callPackage ../libs/libcron.nix { };
in
stdenv.mkDerivation rec {
  pname = "subconverter";
  version = "0.7.1";

  src = fetchgit {
    url = "https://github.com/tindy2013/${pname}";
    rev = "v${version}";
    hash = "sha256-GwkFfR1XLzB9/t7nHPixDFH5nirrOMOH6tHxT42QMDA=";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ libevent curl rapidjson toml11 libyamlcpp pcre2 quickjspp libcron ];
  NIX_CFLAGS_LINK = "-ldl";
}
