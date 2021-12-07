{ python3Packages, fetchgit, wrapGAppsHook, gtk3, gobject-introspection, bamf, keybinder3, ... }:
python3Packages.buildPythonPackage rec {
  pname = "Fildem";
  version = "0.6.7";

  src = fetchgit {
    url = "https://github.com/gonzaarcr/Fildem";
    rev = "${version}";
    hash = "sha256-qly934EaWY9noDQ1L7X06NjGr5PFMjTIjY8esLcn0tE=";
  };

  nativeBuildInputs = [ wrapGAppsHook ];
  buildInputs = with python3Packages; [ pygobject3 ]
    # https://stackoverflow.com/questions/56823857/valueerror-namespace-gtk-not-available
    ++ [ gtk3 gobject-introspection ] ++ [ bamf ] ++ [ keybinder3 ];
  setuptoolsCheckPhase = "echo -n";
  propagatedBuildInputs = with python3Packages;
    [ pygobject3 dbus-python ];
}
