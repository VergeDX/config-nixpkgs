{ stdenv, fetchFromGitHub, automake, autoconf, which, libtool, pkg-config, mono, makeWrapper, pkgs, sqlite }:
stdenv.mkDerivation rec {
  pname = "xsp";
  version = "4.7.1";

  src = fetchFromGitHub {
    owner = "mono";
    repo = "xsp";
    rev = version;
    sha256 = "sha256-Hz4NWmWagGcQSnXJpDqCzeU3yya6iIkmAbmMemL+haU=";
  };

  nativeBuildInputs =
    [ automake autoconf which libtool pkg-config mono makeWrapper ];

  preConfigure = ''
    patchShebangs .
    ./autogen.sh
  '';

  configureFlags = [ "--disable-docs" ];

  LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [ sqlite ]}";

  postInstall = ''
    for f in $out/bin/*;do
      wrapProgram $f --set MONO_PATH $out/lib/mono/4.5
    done
  '';
}
