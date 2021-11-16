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
in
{
  services.hadoop = {
    hdfs = { namenode.enabled = true; datanode.enabled = true; };
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
  services.hadoop.package = hadoop-fixed;
  environment.systemPackages = [ hadoop-fixed ];
}
