{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gnome-shell-extension-lockkeys";
  version = "7fff209";

  src = fetchgit {
    url = "https://github.com/kazysmaster/gnome-shell-extension-lockkeys";
    rev = "${version}9f8c468a99287c2a99004a0175b8af4f5";
    sha256 = "sha256-DVeWXJTwizhtJEKBpFSTpaYNpyUyMJHBGvlk0UiUflA=";
  };

  uuid = "lockkeys@vaina.lt";
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/desktops/gnome/extensions/buildGnomeExtension.nix#L39
  buildCommand = ''
    mkdir -p $out/share/gnome-shell/extensions/
    cp -r -T $src/${uuid} $out/share/gnome-shell/extensions/${uuid}
  '';
}
