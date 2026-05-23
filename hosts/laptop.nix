{
  imports = [
    ./common.nix
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/games/steam.nix
    ../modules/games/minecraft.nix
    ../modules/fonts.nix
    ../modules/packages.nix
    ../modules/hyprland
    ../modules/tex.nix
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "laptop";

  system.stateVersion = "23.11";
  home-manager.users.may.home.stateVersion = "25.11";
}
