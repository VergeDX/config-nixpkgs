{ ... }:
{
  # https://github.com/NixOS/nixpkgs/issues/98050#issuecomment-860272122
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.avahi.publish.enable = true;
  services.avahi.publish = { domain = true; addresses = true; };
}