{ config, lib, pkgs, ... }: {

  hardware.graphics.enable = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "595.80";
      sha256_64bit = "sha256-PVTIP+B/01c/8M66hXTAYTLg9T2Hy9u1gq43K7TF1Hg=";
      sha256_aarch64 = lib.fakeSha256;
      openSha256 = lib.fakeSha256;
      settingsSha256 = "sha256-AtzYTz7kbmj3vxmBQTC0eAjM3b2I259y1tdxq90n9YU=";
      persistencedSha256 = lib.fakeSha256;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  home-manager.users.may.home.packages = with pkgs; [
    nvtopPackages.nvidia
  ];
}
