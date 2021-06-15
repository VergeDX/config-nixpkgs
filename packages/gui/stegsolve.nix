{ stdenv, fetchurl, buildFHSUserEnv }:
let
  stegsolve = stdenv.mkDerivation rec {
    name = "stegsolve";
    src = fetchurl {
      url = "http://www.caesum.com/handbook/Stegsolve.jar";
      sha256 = "sha256-AHtJYGZ485li7a24deWuSsWI6gWIxR3u/N48jcT65Vo=";
    };
  };
in
buildFHSUserEnv {
  name = stegsolve.name;
  targetPkgs = pkgs: [ pkgs.jetbrains.jdk ];
  runScript = "java -jar ${stegsolve.src}";
}
