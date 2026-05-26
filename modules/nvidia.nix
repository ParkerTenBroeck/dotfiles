{ config, lib, pkgs, ... }: {

  hardware.graphics.enable = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  home-manager.users.may.home.packages = with pkgs; [
    nvtopPackages.nvidia
  ];
}
