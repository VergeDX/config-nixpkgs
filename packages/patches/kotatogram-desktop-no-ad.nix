{ pkgs, ... }:
pkgs.nur.repos.ilya-fedin.kotatogram-desktop.overrideAttrs (old: {
  patches = [ ./no-sponsored_messages.patch ];
})
