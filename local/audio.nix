{ ... }:
{
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # https://nixos.wiki/wiki/PipeWire
  # https://blog.ryey.icu/zhs/replace-pulseaudio-with-pipewire.html
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
