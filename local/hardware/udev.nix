{ ... }:
{
  # https://bbs.archlinux.org/viewtopic.php?id=122180
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{product}== "Arduino Uno", GROUP="users", MODE="0666"
    SUBSYSTEMS=="usb", ATTRS{product}== "FT232R USB UART", GROUP="users", MODE="0666"
  '';
}
