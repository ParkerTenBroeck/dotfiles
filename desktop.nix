{ lib, ... }:

{
  imports = [
    ./common.nix
    ./modules/networking.nix
    ./modules/bluetooth.nix
    ./modules/amd.nix
    ./modules/games/steam.nix
    ./modules/games/minecraft.nix
    ./modules/fonts.nix
    ./modules/packages.nix
    ./modules/wireguard-server.nix
    ./modules/hyprland
    ./modules/tex.nix
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos-desktop";
  networking.firewall.allowedTCPPorts = [ 51820 25565 42069 8000 8080 ];

  home-manager.users.may.wayland.windowManager.hyprland.settings = {
    workspace = [
      "1, monitor:DP-2, default:true"
      "9, monitor:DP-1, default:true"
      "10, monitor:HDMI-A-1, default:true"
    ];

    exec-once = lib.mkAfter [
      # Give Hyprland a moment to finish bringing up the desktop before
      # placing startup apps onto monitor-pinned workspaces.
      "sh -c 'sleep 2; hyprctl dispatch exec \"[workspace 9 silent] firefox\"; hyprctl dispatch exec \"[workspace 1 silent] alacritty\"'"
    ];
  };

  system.stateVersion = "23.11";
  home-manager.users.may.home.stateVersion = "25.11";
}
