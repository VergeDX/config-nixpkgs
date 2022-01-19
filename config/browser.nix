{ programs, home, pkgs, inputs, system, ... }:
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

  # https://nix-community.github.io/home-manager/options.html#opt-programs.chromium.extensions
  programs.chromium.extensions = [{
    id = "kpbnombpnpcffllnianjibmpadjolanh";
    crxPath = toString (pkgs.fetchurl {
      url = "https://github.com/bilibili-helper/bilibili-helper-o" +
        "/releases/download/v1.2.30/bilibilihelper_1.2.30.crx";
      hash = "sha256-ippD8jJ9C6AO41ywDRmbE2omphcGuZIf/t/mQpSDwEk=";
    });

    # https://github.com/bilibili-helper/bilibili-helper-o/releases
    version = "v1.2.30";
  }];

  # https://wiki.archlinux.org/title/Chromium_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
  # https://gist.github.com/foutrelis/14e339596b89813aa9c37fd1b4e5d9d5
  systemd.user.sessionVariables = {
    GOOGLE_DEFAULT_CLIENT_ID = "77185425430.apps.googleusercontent.com";
    GOOGLE_DEFAULT_CLIENT_SECRET = "OTJgUOQcT7lO7GsGZq2G4IlT";
  };

  # https://github.com/NixOS/nixpkgs/issues/101223#issuecomment-983745849
  home.packages = [
    # https://github.com/NixOS/nixpkgs/issues/101223#issuecomment-984271996
    # (pkgs.callPackage (import "${inputs.zanc-overlays}/edge").stable { })
  ];
}
