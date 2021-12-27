{ ... }:
{
  services.postgresql.enable = true;

  # https://nixos.wiki/wiki/PostgreSQL
  services.postgresql.authentication =
    # https://stackoverflow.com/questions/18664074/getting-error-peer-authentication-failed-for-user-postgres-when-trying-to-ge
    "local all meh md5";
}
