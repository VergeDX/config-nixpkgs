{ pkgs, lib, config, ... }:
{
  services.telegraf.enable = true;
  services.telegraf.environmentFiles = [
    /run/secrets/telegraf/INFLUX_TOKEN.env
    /run/secrets/telegraf/config.env
  ];

  systemd.services."telegraf".serviceConfig = let dir = "/tmp/telegraf/"; in
    {
      "ExecStart" =
        let script = pkgs.writeText "isv.sh" ''
          # https://docs.influxdata.com/influxdb/v1.8/administration/https_setup/#connect-telegraf-to-a-secured-influxdb-instance
          mkdir -p ${dir} && rm ${dir}/telegraf.conf && true

          # https://stackoverflow.com/questions/65768636/influxdb-reports-unauthorized-access-with-the-generated-token
          ${pkgs.curl}/bin/curl $config -k --header "Authorization: Token $INFLUX_TOKEN" > ${dir}/telegraf.conf && chmod o-r ${dir}/telegraf.conf

          # https://stackoverflow.com/questions/6537490/insert-a-line-at-specific-line-number-with-sed-or-awk/6537587
          ${pkgs.gnused}/bin/sed -i '65i  insecure_skip_verify = true' ${dir}/telegraf.conf
          ${config.services.telegraf.package}/bin/telegraf --config ${dir}/telegraf.conf
        '';
        in
        lib.mkForce "${pkgs.bash}/bin/bash ${script}";

      # https://unix.stackexchange.com/questions/39226/how-to-run-a-script-with-systemd-right-before-shutdown
      "ExecStop" = "/run/current-system/sw/bin/rm ${dir}/telegraf.conf";
    };
}
