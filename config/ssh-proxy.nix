{ ... }:
let proxy = host: {
  inherit host; user = "root";
  proxyCommand = "nc -X connect -x localhost:8889 %h %p";
}; in
{
  programs.ssh.matchBlocks = {
    # "206.189.44.138" = (proxy "206.189.44.138");
    "159.65.135.68" = (proxy "159.65.135.68");
  };
}
