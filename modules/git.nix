{ pkgs, ...}: {
  home-manager.users.may.home.packages = with pkgs; [ 
    git
    gitui
    # yes I'm a baby I know
    gh
  ];
}