{ pkgs, ...}: {
  home-manager.users.may.home.packages = with pkgs; [
    arduino
    arduino-ide
  ];
}