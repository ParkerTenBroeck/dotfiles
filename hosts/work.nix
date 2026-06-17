{ pkgs, lib, config, ... }:

let
  lua = lib.generators.mkLuaInline;
  toLua = lib.generators.toLua { };

  hyprOneLine = script:
    "sh -c ${lib.escapeShellArg (lib.concatStringsSep "; " (
      builtins.filter (line: line != "") (
        map lib.trim (lib.splitString "\n" script)
      )
    ))}";

  hyprRun = pkgs.writeShellScript "hypr-run-igpu" ''
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_DESKTOP=Hyprland
    export WLR_DRM_DEVICES=/dev/dri/by-path/pci-0000:00:02.0-card
    export _JAVA_AWT_WM_NONREPARENTING=1
    export XCURSOR_SIZE=24

    exec ${pkgs.hyprland}/bin/Hyprland
  '';
in {
  imports = [
    ./common.nix
    /home/may/Documents/wt/server_config/modules/website
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/fonts.nix
    ../modules/packages.nix
    ../modules/tex.nix
    ../modules/docker.nix
    ../modules/hyprland
  ];

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;
  users.users.may.extraGroups = [ "docker" ];

  networking.hostName = "work";
  networking.firewall.allowedTCPPorts = [ 5900 8026 25565 42069 8000 8080 ];

  programs.nix-ld.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidiaOptimus.disable = true;

  services.xserver.videoDrivers = [ "modesetting" ];

  environment.sessionVariables = {
    WLR_DRM_DEVICES = "/dev/dri/by-path/pci-0000:00:02.0-card";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    XCURSOR_SIZE = "24";
  };

  services.wtSite = {
    enable = true;
    gitBase = "/home/may/Documents/wt/wt-git";
    privBase = "/home/may/Documents/wt/wt-priv";
    localBase = "/home/may/Documents/wt/wt-local";
    tmpBase = "/home/may/Documents/wt/wt-tmp";
    envKind = "dev";
    siteDomain = "www.wt.com";
    portForwarding.enable = false;
    user = "may";
    group = "users";
  };

  home-manager.users.may.programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks.wt = {
      hostname = "host.westminsterteak.com";
      user = "adminster";
      port = 22448;
      setEnv.TERM = "xterm-256color";
      identityFile = "~/.ssh/wt_rsa";
    };

    matchBlocks.host_wt = {
      hostname = "hostv2.westminsterteak.com";
      user = "admin";
      port = 22448;
      setEnv.TERM = "xterm-256color";
      identityFile = "~/.ssh/wt_ed25519";
    };

    matchBlocks.site_wt = {
      hostname = "hostv2.westminsterteak.com";
      user = "admin";
      port = 22100;
      setEnv.TERM = "xterm-256color";
      identityFile = "~/.ssh/wt_ed25519";
    };

    matchBlocks.revprox_wt = {
      hostname = "hostv2.westminsterteak.com";
      user = "admin";
      port = 22101;
      setEnv.TERM = "xterm-256color";
      identityFile = "~/.ssh/wt_ed25519";
    };

    matchBlocks.staging_wt = {
      hostname = "hostv2.westminsterteak.com";
      user = "admin";
      port = 22102;
      setEnv.TERM = "xterm-256color";
      identityFile = "~/.ssh/wt_ed25519";
    };   

    matchBlocks.legacy_wt = {
      hostname = "hostv2.westminsterteak.com";
      user = "admin";
      port = 22103;
      setEnv.TERM = "xterm-256color";
      identityFile = "~/.ssh/wt_ed25519";
    };
  };

  home-manager.users.may.wayland.windowManager.hyprland.settings.on = lib.mkAfter [
    {
      _args = [
        "hyprland.start"
        (lua ''
          function()
            hl.exec_cmd(${toLua (hyprOneLine ''
              sleep 2

              hyprctl dispatch exec "[workspace 1 silent] chromium --restore-last-session"

              hyprctl dispatch exec "[workspace 2 silent] code /home/may/Documents/GitHub/wt"
              hyprctl dispatch exec "[workspace 2 silent] alacritty --working-directory /home/may/Documents/GitHub/wt"

              hyprctl dispatch exec "[workspace 2 silent] code /home/may/Documents/GitHub/mywt"
              hyprctl dispatch exec "[workspace 2 silent] alacritty --working-directory /home/may/Documents/GitHub/mywt"

              hyprctl dispatch exec "[workspace 4 silent] firefox"
            '')})
          end
        '')
      ];
    }
  ];

  home-manager.users.may.home.packages = with pkgs; [
    chromium
    docker
    killall
    wayvnc
    wlr-randr
  ];

  services.greetd = lib.mkIf (config.services.greetd.enable && config.programs.hyprland.enable) {
    settings = {
      initial_session.command = lib.mkForce "${hyprRun}";
      default_session.command =
        lib.mkForce "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${hyprRun}";
    };
  };

  home-manager.users.may.home.stateVersion = "25.11";
}
