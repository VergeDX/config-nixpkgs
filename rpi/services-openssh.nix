{ ... }:
{
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  users.users.vanilla.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNV2Q1yXZm0mx/SakkZDaqq1wZG9tpk/I09BoAFg51RyZyKiPAXixTz60fUlPmhnBKKauj/J9CSMd5TqeU466itN+A/87cT2rCiSPjMx9aQnJ3RANHi1QBgWnARyvR+/Dk5u0bV+ZVVjexmcapa7jA9i7hFIowqniQWeab7by8XWKebe68UWZ9eQ7A18iahCdHFvwl1uh+3TUjk+aaox7QWGMcqoZDqSB94PARncp95K2orHUouI373b/cnDonbzuCadMosGDeyEZPP4H7yat59GvVhnFbvVU3Yudbmd76G1EWaZkxMlKnGo8+ei/kbIaO0acc/4LrrTqJMFKqll3pFtyp59guJZz0jB2+NIJL99IjAhUwtpDsE+qZ4cE6OW5QJcOxS6YRhsXyIWuj8dqGwvv09GPjC/jskyKoC9b1vRsWwJECFg5bbOA/ObTv4QvQWjKUFtFUZVlDgrgQM6uhMxQwnyoV4j98roUG8Axnae/Aqj1JeeXAA7IRBL2qMdc= osu_Vanilla@126.com"
  ];

  services.fail2ban.enable = true;
  services.fail2ban.bantime-increment.enable = true;
}
