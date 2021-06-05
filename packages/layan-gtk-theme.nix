let
  pkgs = import <nixpkgs> { };
  layan-gtk-theme = pkgs.vimix-gtk-themes.overrideAttrs (old: {
    pname = "layan-gtk-theme";
    version = "master";

    src = pkgs.fetchgit {
      url = "https://github.com/vinceliuice/Layan-gtk-theme";
      sha256 = "sha256:0b637di3ihw34gm61jh6snj0446xymmz7mf7va7vyz8ybnhqh46r";
    };
  });
in
layan-gtk-theme
