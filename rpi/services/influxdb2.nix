{ ... }:
let CREDENTIALS_DIRECTORY = "/run/credentials/influxdb2.service"; in
{
  services.influxdb2.enable = true;

  # https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Credentials
  systemd.services."influxdb2".serviceConfig."LoadCredential" = [
    "crt:/run/secrets/influxdb2/influxdb-selfsigned.crt"
    "key:/run/secrets/influxdb2/influxdb-selfsigned.key"
  ];

  # https://docs.influxdata.com/influxdb/v2.0/security/enable-tls/
  services.influxdb2.settings = {
    "tls-cert" = "${CREDENTIALS_DIRECTORY}/crt";
    "tls-key" = "${CREDENTIALS_DIRECTORY}/key";
  };
}
