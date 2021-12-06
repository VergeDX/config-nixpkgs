{ ... }:
let proxy = host: {
  inherit host; user = "root";
  proxyCommand = "nc -X connect -x localhost:8889 %h %p";
}; in
{
  programs.ssh.matchBlocks = {
    "206.189.44.138" = (proxy "206.189.44.138");
    "134.209.111.162" = (proxy "134.209.111.162");
  };
}
