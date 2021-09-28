{ ... }:
{
  nix.gc.automatic = true;
  nix.gc = { dates = "daily"; options = "-d"; };
}
