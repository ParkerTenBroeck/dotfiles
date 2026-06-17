{ pkgs, ...}: {
  imports = [
    ./common.nix
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/games/steam.nix
    ../modules/games/minecraft.nix
    ../modules/hyprland
    ../modules/nvidia.nix
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "thinkpad";

  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:0:0:0";
  };


  home-manager.users.may.home.stateVersion = "26.05";
}
