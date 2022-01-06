{ inputs, system, ... }:
let pkgsUnstable = (import inputs.nixpkgs-unstable { inherit system; }); in
{
  # https://blog.ryey.icu/zhs/replace-pulseaudio-with-pipewire.html
  sound.enable = true;
  sound.enableOSSEmulation = true;

  # https://nixos.wiki/wiki/PipeWire#Enabling_PipeWire
  services.pipewire.enable = true;
  services.pipewire.package = pkgsUnstable.pipewire;
  hardware.pulseaudio.enable = false;

  # NixOS Search: services.pipewire.*.enable
  services.pipewire = {
    pulse.enable = true;
    jack.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
  };
}
