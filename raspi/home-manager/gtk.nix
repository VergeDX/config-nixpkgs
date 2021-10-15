{ pkgs, ... }:
{
  gtk.enable = true;
  gtk = {
    iconTheme = { package = pkgs.tela-icon-theme; name = "Tela-pink"; };
    theme = { package = pkgs.layan-gtk-theme; name = "Layan-light-solid"; };
  };
}
