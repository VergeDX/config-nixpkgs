{ stdenv, fetchgit, cmake, libsForQt5, pkg-config, botan, ... }:
stdenv.mkDerivation rec {
  pname = "libQtShadowsocks";
  version = "2.1.0";

  src = fetchgit {
    url = "https://github.com/shadowsocks/${pname}";
    rev = "v${version}";
    hash = "sha256-zG1os+UVkbCLN7DwkqQmPdzjC7LCbfdg0roTTdRC9lU=";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ libsForQt5.qtbase botan ];
  dontWrapQtApps = true;
}
