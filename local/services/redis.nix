{ ... }:
{
  services.redis.enable = true;
  services.redis.requirePass = "letmein!";
  services.redis.vmOverCommit = true;
}
