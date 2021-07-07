{ stdenv, fetchgit, cmake, glib, boost, pkg-config, gtk3, ragel, lua, lib }:

stdenv.mkDerivation rec {
  name = "gpick";
  version = "0.2.6";

  src = fetchgit {
    url = "https://github.com/thezbyg/${name}";
    rev = "${name}-${version}";
    sha256 = "sha256-Z67EJRtKJZLoTUtdMttVTLkzTV2F5rKZ96vaothLiFo=";
  };

  nativeBuildInputs = [ cmake ];
  NIX_CFLAGS_COMPILE = "-I${glib.dev}/include/gio-unix-2.0";
  buildInputs = [ boost pkg-config gtk3 ragel lua ];

  meta = with lib; {
    description = "Advanced color picker written in C++ using GTK+ toolkit";
    homepage = "http://www.gpick.org/";
    license = licenses.bsd3;
    maintainers = [ maintainers.vanilla ];
    platforms = platforms.linux;
  };
}
