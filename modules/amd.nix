{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  home-manager.users.may.home.packages = with pkgs; [ lact ];

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };
}
