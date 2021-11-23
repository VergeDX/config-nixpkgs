{ pkgs, ... }:
let
  tmpBase = "file:/tmp";
  hadoop-fixed = pkgs.hadoop.overrideAttrs (old: {
    src = old.src.overrideAttrs (old: {
      # https://github.com/apache/hadoop/pull/2886/files
      # https://stackoverflow.com/questions/22159044
      patchPhase = ''
        sed -i '114s/$/ || defined(__GLIBC_PREREQ) \&\& __GLIBC_PREREQ(2, 32)/' \
          hadoop-common-project/hadoop-common/src/main/native/src/exception.c
      '';
    });
  });
  hadoop-fixed-FHS = pkgs.buildFHSUserEnv rec {
    name = "hadoop";
    targetPkgs = pkgs: [ hadoop-fixed ];
    runScript = "${name}";
  };
  hdfs-FHS = pkgs.buildFHSUserEnv rec {
    name = "hdfs";
    targetPkgs = pkgs: [ hadoop-fixed ];
    runScript = "${name}";
  };
  hadoop-final = pkgs.stdenv.mkDerivation {
    name = "hadoop-final";
    version = "${hadoop-fixed.version}";
    src = hadoop-fixed-FHS;

    installPhase = ''
      mkdir -p $out/bin/
      ln -s ${hadoop-fixed-FHS}/bin/hadoop $out/bin/hadoop
      ln -s ${hdfs-FHS}/bin/hdfs $out/bin/hdfs
    '';
  };
in
{
  services.hadoop = {
    hdfs = { namenode.enable = true; datanode.enable = true; };
    # yarn = { resourcemanager.enabled = true; nodemanager.enabled = true; };
  };

  services.hadoop = {
    coreSite = {
      "hadoop.tmp.dir" = "${tmpBase}";
      "fs.defaultFS" = "hdfs://localhost";
    };

    hdfsSite = {
      "dfs.replication" = "1";
      "dfs.namenode.name.dir" = "${tmpBase}/dfs/name";
      "dfs.datanode.data.dir" = "${tmpBase}/dfs/data";
    };
  };

  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.0.2u" ];
  # services.hadoop.package = hadoop-final;
  environment.systemPackages = [ hadoop-final ];
}
