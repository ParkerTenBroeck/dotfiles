{ pkgs, ...}: {
  home-manager.users.may.home.packages = with pkgs; [ 
    texstudio
    texlive.combined.scheme-full
  ];
}