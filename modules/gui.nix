{ pkgs, ...}: {
  
  imports = [
    ./kitty.nix
    ./udisks2.nix
  ];

  home-manager.users.may.home.packages = with pkgs; [ 
    firefox             # browser
    nautilus            # gui file manager 
    imv                 # image viewer
    file-roller         # archive manager
    vscode              # text editor
    gnome-disk-utility
    vlc                 # video player
  ];
}
