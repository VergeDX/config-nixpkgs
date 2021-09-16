{ tdesktop, cpp-gsl }:
tdesktop.overrideAttrs (old: rec {
  pname = old.pname + "-beta";
  version = "3.0.4";

  buildInputs = old.buildInputs ++ [ cpp-gsl ];
  src = old.src.overrideAttrs (old: {
    rev = "v${version}";
    outputHash = "sha256-ht91deHyaot2oPdmSGpyVvJVVo7nrBaq9Ld3eTFvpaE=";
  });
})
