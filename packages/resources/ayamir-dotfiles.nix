{ stdenv, fetchgit, ... }:
stdenv.mkDerivation rec {
  pname = "ayamir-dotfiles";
  version = "master";

  src = fetchgit {
    url = "https://github.com/ayamir/dotfiles";
    sha256 = "sha256-nitcWJSqGxvX+f+2gwwSNrzCguUHC18xDVHkfIBK2kk=";
  };

  # patchPhase = "echo -n > ./gruvbox/.config/neofetch/archlogo.txt";
  # installPhase = "mkdir $out && cp -r * $out";

  installPhase = "ln -s ${src} $out";
  fixupPhase = "echo -n";
}
