{ pkgs, ...}: {
  imports = [
    ./chawan.nix
    ./editors
  ];
  
  home-manager.users.may.home.packages = with pkgs; [ 
    fastfetch
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
