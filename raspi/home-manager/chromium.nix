{ pkgs, ... }:
{
  programs.chromium.enable = true;
  # https://www.linuxuprising.com/2021/04/how-to-enable-hardware-acceleration-in.html
  programs.chromium.package = pkgs.chromium.override {
    # https://wiki.archlinux.org/title/Chromium#Making_flags_persistent
    # https://forums.raspberrypi.com/viewtopic.php?t=319304
    commandLineArgs = ''
      --ignore-gpu-blocklist \
      --enable-accelerated-video-decode \
      --enable-gpu-rasterization \
      --enable-features=VaapiVideoDecoder \
      --use-gl=desktop \
    '';
  };
}
