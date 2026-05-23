{
  imports = [
    ./common.nix
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/fonts.nix
    ../modules/packages.nix
    ../modules/hyprland
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "work";

  system.stateVersion = "23.11";
  home-manager.users.may.home.stateVersion = "25.11";
}
