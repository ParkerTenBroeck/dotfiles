{ pkgs, ... }:

{
  users.users.may = {
    isNormalUser = true;
    description = "may";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.may = { pkgs, ... }: {
    home = {
      username = "may";
      homeDirectory = "/home/may";
    };
  };
}
