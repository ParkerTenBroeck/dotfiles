{ pkgs, ... }:

let
  agenixSrc = builtins.fetchTarball "https://github.com/ryantm/agenix/archive/main.tar.gz";
in {
  imports = [
    "${agenixSrc}/modules/age.nix"
  ];

  environment.systemPackages = [
    (pkgs.callPackage "${agenixSrc}/pkgs/agenix.nix" { })
  ];
}
