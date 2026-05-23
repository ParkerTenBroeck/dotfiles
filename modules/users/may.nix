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

    home.packages = with pkgs; [
      firefox
      chromium
      vlc
      spotify
      vscode
      jetbrains.idea
      obs-studio
      gh
      jetbrains.rust-rover
      wayvnc
    ];
  };
}
