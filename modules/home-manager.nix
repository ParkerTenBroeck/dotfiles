{
  imports = [
    (import <home-manager/nixos>)
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
}
