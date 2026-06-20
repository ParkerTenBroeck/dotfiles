{ pkgs, ...}: {
  
  imports = [
    ./kitty.nix
    ./udisks2.nix
  ];



  home-manager.users.may = { config, lib, pkgs, ... }: {
    
    programs.vscode.enable = true;

    home.packages = with pkgs; [
      firefox             # browser
      nautilus            # gui file manager
      imv                 # image viewer
      file-roller         # archive manager
      gnome-disk-utility
      vlc                 # video player
    ];
  };
}
