{ callPackage, runCommand, python3, ... }:
let Fildem = callPackage ./Fildem.nix { }; in
let myPython = python3.withPackages (p: [ Fildem ]); in
runCommand "Fildem-run" { } ''
  mkdir -p $out/bin && touch $out/bin/fildem && chmod +x $out/bin/fildem
  cat ${Fildem}/bin/fildem > $out/bin/fildem && sed -i '1d;4d' $out/bin/fildem
  echo '${myPython}/bin/python3 -c "from fildem.run import main; main()"' >> $out/bin/fildem
''
