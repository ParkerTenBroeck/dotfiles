{
  imports = [
    (import ((builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz") + "/nixos"))
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
}
