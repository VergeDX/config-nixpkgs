{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  name = "checkra1n";
  version = "0.12.4-beta";

  src = fetchurl {
    url = "https://assets.checkra.in/downloads/linux/cli/x86_64/dac9968939ea6e6bfbdedeb41d7e2579c4711dc2c5083f91dced66ca397dc51d/${name}";
    sha256 = "sha256-2smWiTnqbmv73t60HX4lecRxHcLFCD+R3O1myjl9xR0=";
  };

  unpackPhase = "echo";
  installPhase = ''
    mkdir -p $out/bin/
    cp ${src} $out/bin/${name}
    chmod +x $out/bin/${name}
  '';
}
