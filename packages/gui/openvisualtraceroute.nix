{ stdenv, fetchgit, jetbrains, ant, makeWrapper, ... }:
stdenv.mkDerivation rec {
  pname = "openvisualtraceroute";
  version = "4e4f3c3";

  src = fetchgit {
    url = "https://github.com/leolewis/${pname}";
    rev = "${version}05fa5f24e4784588c48360c5b277c6a2c";
    sha256 = "sha256-s5WglTpO68iF+2U2FXYQ40NuqINWV7/JmT7ZVYPGDJM=";
  };

  nativeBuildInputs = [ jetbrains.jdk ant makeWrapper ];
  buildPhase = "cd ./org.leo.traceroute/ && ant compile";
  installPhase = ''
    ant -Ddest.dir=$out/ jar prepare
    mkdir -p $out/bin
    makeWrapper ${jetbrains.jdk}/bin/java $out/bin/ovtr \
      --add-flags "-jar $out/org.leo.traceroute.jar"
  '';
}
