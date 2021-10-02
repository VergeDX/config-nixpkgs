{ pkgs, lib, config, ... }:
{
  services.telegraf.enable = true;
  services.telegraf.environmentFiles = [
    /run/secrets/telegraf/INFLUX_TOKEN.env
    /run/secrets/telegraf/config.env
  ];

  systemd.services."telegraf".serviceConfig =
    let
      cfg_dir = "/tmp/telegraf";
      cfg_file = "${cfg_dir}/telegraf.conf";

      # https://nixos.wiki/wiki/Python
      my-python-packages = python-packages: with python-packages; [ toml ];
      python-with-my-packages = pkgs.python3.withPackages my-python-packages;

      toml_parse = pkgs.writeText "isv.py" ''
        #! /usr/bin/env python3
        import toml

        with open('${cfg_file}.old', 'r') as f:
            # https://github.com/uiri/toml#quick-tutorial
            parsed_toml = toml.loads(f.read())

            ISV = 'insecure_skip_verify'
            # https://docs.influxdata.com/influxdb/v2.0/security/enable-tls/
            parsed_toml['outputs']['influxdb_v2'][0][ISV] = True
            # https://github.com/influxdata/telegraf/pull/2883/files
            if parsed_toml.get('inputs').get('nginx') is not None:
                parsed_toml['inputs']['nginx'][0][ISV] = True

            new_toml_string = toml.dumps(parsed_toml)
            print(new_toml_string)
      '';
    in
    {
      "ExecStart" =
        let script = pkgs.writeText "isv.sh" ''
          #! /usr/bin/env bash
          rm -r ${cfg_dir}/ || true && mkdir -p ${cfg_dir}/
          ${pkgs.curl}/bin/curl $config -k \
              --header "Authorization: Token $INFLUX_TOKEN" \
              > ${cfg_file}.old && chmod o-r ${cfg_file}.old
          ${python-with-my-packages}/bin/python3 ${toml_parse} > ${cfg_file}
          rm ${cfg_file}.old && chmod o-r ${cfg_file}
          ${config.services.telegraf.package}/bin/telegraf --config ${cfg_file}
        '';
        in
        lib.mkForce "${pkgs.bash}/bin/bash ${script}";

      # https://unix.stackexchange.com/questions/39226/how-to-run-a-script-with-systemd-right-before-shutdown
      "ExecStop" = "${pkgs.coreutils}/bin/rm -r ${cfg_dir}/ || true";
    };
}
