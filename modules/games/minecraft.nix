{ pkgs, ...}: {
  home-manager.users.may.home.packages = with pkgs; [ prismlauncher ];
}