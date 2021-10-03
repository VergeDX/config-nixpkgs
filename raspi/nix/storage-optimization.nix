{ ... }:
{
  # https://nixos.wiki/wiki/Storage_optimization#Optimising_the_store
  nix.autoOptimiseStore = true;

  # https://nixos.wiki/wiki/Storage_optimization#Optimising_the_store
  nix.gc.automatic = true;
  nix.gc = { dates = "daily"; options = "-d"; };

  nix.extraOptions = ''
    min-free = ${toString (100 * 1024 * 1024)}
    max-free = ${toString (1024 * 1024 * 1024)}
  '';
}
