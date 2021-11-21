{ stdenv, fetchgit, cmake, ... }:
stdenv.mkDerivation rec {
  pname = "quickjspp";
  version = "2021-03-27";

  src = fetchgit {
    url = "https://github.com/ftk/${pname}";
    # https://github.com/ftk/quickjspp/commit/8f220f3700e8f20225107882e2a28444a8c2fe28
    rev = "8f220f3700e8f20225107882e2a28444a8c2fe28";
    hash = "sha256-RINXRIbmmsEl61YgVhd+A5rp9YxsfsC32Co/9mPTm70=";
  };

  nativeBuildInputs = [ cmake ];

  # https://github.com/tindy2013/subconverter/blob/v0.7.1/scripts/build.alpine.release.sh#L23
  installPhase = ''
    mkdir -p $out/lib/ $out/include/quickjs/ $out/include/
    install -m644 /build/quickjspp-8f220f3/build/quickjs/libquickjs.a $out/lib/
    install -m644 /build/quickjspp-8f220f3/quickjs/quickjs.h $out/include/quickjs/
    install -m644 /build/quickjspp-8f220f3/quickjs/quickjs-libc.h $out/include/quickjs/
    install -m644 /build/quickjspp-8f220f3/quickjspp.hpp $out/include/
  '';
}
