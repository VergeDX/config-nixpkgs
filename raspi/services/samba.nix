{ ... }:
{
  services.samba.enable = true;
  services.samba.openFirewall = true;

  services.samba.shares."public" = {
    path = "/root";

    # https://unix.stackexchange.com/questions/467779
    "force user" = "root";
  };

  # https://unix.stackexchange.com/questions/562933
  services.samba.extraConfig = "restrict anonymous = 2";
}
