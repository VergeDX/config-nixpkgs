{ fetchurl, steam-run-native, runCommand, makeWrapper }:
let
  file = fetchurl {
    url = "https://out7.hex-rays.com/files/idafree76_linux.run";
    sha256 = "sha256-pW10/Efe/Nwi+CHMcKb7HhpjgJ36vQhwIXxnNhPjLqw=";
    executable = true;
  };
  executor = "${steam-run-native}/bin/steam-run";
  binary = runCommand "idafree-bin" { } ''
    ${steam-run-native}/bin/steam-run ${file} --prefix $TEMPDIR --mode unattended
    mkdir -p $out
    cp -R $TMPDIR/* $out
  '';
in
runCommand "idafree" { nativeBuildInputs = [ makeWrapper ]; } ''
  mkdir -p $out/bin
  makeWrapper ${executor} $out/bin/idafree \
    --add-flags ${binary}/ida64
''
