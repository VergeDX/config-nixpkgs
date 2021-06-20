{ appimageTools, fetchurl }:
appimageTools.wrapType2 rec {
  name = "edex-ui";
  src = fetchurl {
    url = "https://github.com/GitSquared/${name}/releases/download/v2.2.7/eDEX-UI-Linux-x86_64.AppImage";
    sha256 = "sha256-bB906NbIN+OJMYYf2fr0Tu+D9F41fqSQHL+2QM+F39I=";
  };
}
