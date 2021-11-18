{ programs, home, pkgs, inputs, system, ... }:
let microsoft-edge-dev = ((import inputs.leo60228-nixpkgs {
  inherit system; config.allowUnfree = true;
}).pkgs.microsoft-edge-beta.overrideAttrs (old: rec {
  pname = "microsoft-edge-dev";
  version = "94.0.982.2";

  src = pkgs.fetchurl {
    url = "https://packages.microsoft.com/repos/edge/pool/main/m/${pname}/${pname}_${version}-1_amd64.deb";
    hash = "sha256-q8qFGqFuwTB2hXbOcOQQA/jAXUt2qjRw5bpH3JdQQJM=";
  };
}));
in
{
  programs.chromium.enable = true;
  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L222
  programs.chromium.package = (pkgs.chromium.override {
    commandLineArgs = ''
      --enable-gpu-rasterization \
      --enable-zero-copy \
      --enable-features=VaapiVideoDecoder \
    '';
  });

  # https://wiki.archlinux.org/title/Chromium_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
  # https://gist.github.com/foutrelis/14e339596b89813aa9c37fd1b4e5d9d5
  systemd.user.sessionVariables = {
    GOOGLE_DEFAULT_CLIENT_ID = "77185425430.apps.googleusercontent.com";
    GOOGLE_DEFAULT_CLIENT_SECRET = "OTJgUOQcT7lO7GsGZq2G4IlT";
  };

  # https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-dev/
  home.packages = [ (microsoft-edge-dev.override { channel = "dev"; }) ];
}
