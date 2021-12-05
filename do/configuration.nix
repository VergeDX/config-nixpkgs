{ ... }:
{
  modules = [ ./services/cloud-init.nix ./services/openssh.nix ]
    ++ [ ./users.nix ];
}
