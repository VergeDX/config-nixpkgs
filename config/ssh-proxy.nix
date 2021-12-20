{ ... }:
let proxy = host: {
  inherit host; user = "root";
  proxyCommand = "nc -X connect -x localhost:8889 %h %p";
}; in
{
  programs.ssh.matchBlocks = {
    "128.199.74.64" = (proxy "128.199.74.64");
    # "159.65.135.68" = (proxy "159.65.135.68");
  };
}
