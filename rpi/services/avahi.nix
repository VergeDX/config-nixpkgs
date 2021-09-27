{ ... }:
{
  # https://github.com/NixOS/nixpkgs/issues/98050#issuecomment-860272122
  services.avahi = { enable = true; nssmdns = true; };
  services.avahi.publish = { enable = true; domain = true; addresses = true; };
}
