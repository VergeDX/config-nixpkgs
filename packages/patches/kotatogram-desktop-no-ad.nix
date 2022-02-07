{ pkgs, ... }:
let dsm = "Telegram/SourceFiles/data/data_sponsored_messages.cpp"; in
pkgs.nur.repos.ilya-fedin.kotatogram-desktop.overrideAttrs (old: {
  patchPhase = "sed -i 's/history->isChannel()/0/g' ${dsm}";
})
