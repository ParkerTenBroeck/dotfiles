{ lib, ... }:

let
  lua = lib.generators.mkLuaInline;
  toLua = lib.generators.toLua { };
in
{
  imports = [
    ./common.nix
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/amd.nix
    ../modules/games/steam.nix
    ../modules/games/minecraft.nix
    ../modules/fonts.nix
    ../modules/packages.nix
    ../modules/wireguard-server.nix
    ../modules/kde
    ../modules/tex.nix
    ../modules/forgejo.nix
    ../modules/revprox.nix
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "desktop";
  networking.firewall.allowedTCPPorts = [ 51820 25565 42069 8000 8080 80 443 ];

  /*
  home-manager.users.may.wayland.windowManager.hyprland.settings = {
    workspace_rule = [
      {
        workspace = "1";
        monitor = "DP-2";
        default = true;
      }
      {
        workspace = "9";
        monitor = "DP-1";
        default = true;
      }
      {
        workspace = "10";
        monitor = "HDMI-A-1";
        default = true;
      }
    ];

    on = lib.mkAfter [
      # Give Hyprland a moment to finish bringing up the desktop before
      # placing startup apps onto monitor-pinned workspaces.
      {
        _args = [
          "hyprland.start"
          (lua ''
            function()
              hl.exec_cmd(${toLua "sh -c 'sleep 2; hyprctl dispatch exec \"[workspace 9 silent] firefox\"; hyprctl dispatch exec \"[workspace 1 silent] alacritty\"'"})
            end
          '')
        ];
      }
    ];
  };
  */

  system.stateVersion = "23.11";
  home-manager.users.may.home.stateVersion = "26.11";
}
