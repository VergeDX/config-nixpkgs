{ ... }:
{
  services.postgresql.enable = true;

  # https://nixos.wiki/wiki/PostgreSQL
  services.postgresql.authentication =
    # https://www.postgresql.org/docs/current/auth-pg-hba-conf.html
    "host all all 127.0.0.1/32 md5";
}
