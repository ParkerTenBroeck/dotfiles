{ pkgs, ...}: {
  services.udev.packages = [ pkgs.saleae-logic-2 ];
  home-manager.users.may.home.packages = [ pkgs.saleae-logic-2 ];
}