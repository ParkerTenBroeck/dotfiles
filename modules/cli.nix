{ pkgs, ...}: {
  imports = [
    ./editors
  ];
  
  home-manager.users.may.home.packages = with pkgs; [ 
    neofetch
    wget
    tmux
    file
    btop
    screen
    ranger # file manager
    ripgrep
  ];
}