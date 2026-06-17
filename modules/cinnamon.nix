{
  imports = [
    # assume any desktop env will have audio
    ./audio.nix
    ./gui.nix
  ];


  services.xserver.enable = true;

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
}
