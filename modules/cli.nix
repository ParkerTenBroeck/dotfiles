{ pkgs, ...}: {
  imports = [
    ./editors
  ];
  
  home-manager.users.may.home.packages = with pkgs; [ 
    hyfetch
    wget
    tmux
    file
    btop
    screen
    ranger # file manager
    ripgrep
    cloc
    gdu
  ];
}
