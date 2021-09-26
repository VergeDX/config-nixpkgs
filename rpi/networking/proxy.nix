{ ... }:
{
  # Configure network proxy if necessary
  networking.proxy.default = "http://NixOS-Laptop.local:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
