{ pkgs }:
let
  armitage = pkgs.stdenv.mkDerivation rec {
    name = "armitage";
    version = "150813";

    src = pkgs.fetchurl {
      url = "http://www.fastandeasyhacking.com/download/${name}${version}.tgz";
      sha256 = "sha256-KIBlqLd5tqT0rKoDMvLrv9AiUp9gDkv3DNSU2Ehg9qw=";
    };

    installPhase = "mkdir -p $out/${name} && cp * $out/${name}";
  };
in
pkgs.buildFHSUserEnv {
  name = armitage.name;
  targetPkgs = pkgs: [ pkgs.jdk11 ];
  runScript = "java -jar ${armitage.out}/${armitage.name}/armitage.jar";
}
