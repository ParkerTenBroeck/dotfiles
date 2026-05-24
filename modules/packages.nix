{ pkgs, ... }:

{
  # assorted stuff until I decide where it goes
  home-manager.users.may = { pkgs, ... }: {
    home.packages = with pkgs; [
      openjdk21
      vlc
      spotify
      jetbrains.idea
      obs-studio
      discord
      jetbrains.rust-rover
      halloy
      dino
    ];
  };
}
