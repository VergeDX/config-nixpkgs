{ programs, home, pkgs, ... }:
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

  # https://nur.nix-community.org/repos/xe/
  home.packages = [
    (pkgs.nur.repos.xe.microsoft-edge-dev.overrideAttrs (old: {
      src = pkgs.fetchurl {
        url = "https://github.com/Sirherobrine23/APT_bysh23/raw/master/package/not-bysh23/microsoft-edge-dev_88.0.673.0-1_amd64.deb";
        hash = "sha256-/9ACwjK/tU8jZIvVbkvsYMdOrjXBnx5FwV6EoqEU0+E=";
      };
    }))
  ];
}
