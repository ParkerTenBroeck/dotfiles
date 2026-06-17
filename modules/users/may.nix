{ pkgs, ... }:

{
  users.users.may = {
    isNormalUser = true;
    description = "may";
    extraGroups = [ "networkmanager" "storage" "video" "wheel" ];
  };

  home-manager.users.may = { pkgs, ... }: {
    home = {
      username = "may";
      homeDirectory = "/home/may";
    };
  };
}
