{ pkgs, ... }:
{
  users.mutableUsers = false;
  users.users.root.hashedPassword = "$6$GitHub/Edu/DO$8MDyr3Dh4RIHql9aN0vCBOkf2A8bKbBPo4v85HQ7OSYQVDuCave.u9QrhFGx7ZoRwJjZx14fgrK61Zf0arWZM.";
  users.users.root.shell = pkgs.fish;
}
