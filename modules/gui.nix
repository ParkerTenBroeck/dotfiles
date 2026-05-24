{ pkgs, ...}: {
  home-manager.users.may.home.packages = with pkgs; [ 
    firefox             # browser
    nautilus            # gui file manager
    alacritty           # terminal
    imv                 # image viewer
    file-roller         # archive manager
    vscode              # text editor
    gnome-disk-utility
  ];
}