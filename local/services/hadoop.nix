{ pkgs, ... }:
{
  services.hadoop = {
    hdfs = { namenode.enable = true; datanode.enable = true; };
    yarn = { resourcemanager.enable = true; nodemanager.enable = true; };
  };

  # https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html
  services.hadoop = {
    coreSite = { "fs.defaultFS" = "hdfs://localhost:9000"; };
    hdfsSite = { "dfs.replication" = "1"; };
  };

  # sudo -u hdfs hadoop namenode -format
  services.hadoop.package = pkgs.hadoop;
  environment.systemPackages = [ pkgs.hadoop ];
}
