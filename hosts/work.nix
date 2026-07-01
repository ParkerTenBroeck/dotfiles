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

  sshTmux = {
    # RequestTTY = "force";
    # RemoteCommand = "[[ $- != *i* ]] && return; tmux new-session -A -s parker";
  };
in {
  imports = [
    ./common.nix
    /home/may/Documents/wt/system_config/modules/website
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/fonts.nix
    ../modules/packages.nix
    ../modules/tex.nix
    ../modules/docker.nix
    ../modules/hyprland
    ../modules/nvidia.nix
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

  # hardware.nvidiaOptimus.disable = true;
  # services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:0:0:0";
  };


  environment.sessionVariables = {
    XCURSOR_SIZE = "24";
  };

  services.wtSite = {
    enable = true;
    paths.root = "/home/may/Documents/wt";
    envKind = "dev";
    siteDomain = "www.wt.com";
    xdebug = {
      enable = true;
        mode = "debug";
        startWithRequest = "yes";
        discoverClientHost = false;
        clientHost = "127.0.0.1";
        clientPort = 9003;
        log = "/tmp/xdebug.log";
        idekey = "VSCODE";
    };

    portForwarding.enable = false;
    user = "may";
    group = "users";
    httpCache = {
      enable = false;
      maxAge = 86400;
    };
  };

  home-manager.users.may.programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings.wt = {
      HostName = "host.westminsterteak.com";
      User = "adminster";
      Port = 22448;
      SetEnv.TERM = "xterm-256color";
      IdentityFile = "~/.ssh/wt_rsa";
    };

    settings.wt_root = {
      HostName = "host.westminsterteak.com";
      User = "root";
      Port = 22448;
      SetEnv.TERM = "xterm-256color";
      IdentityFile = "~/.ssh/wt_rsa";
    };

    settings.host_wt = {
      HostName = "hostv2.westminsterteak.com";
      User = "admin";
      Port = 22448;
      SetEnv.TERM = "xterm-256color";
      IdentityFile = "~/.ssh/wt_ed25519";
    };

    settings.prod_wt = {
      HostName = "hostv2.westminsterteak.com";
      User = "admin";
      Port = 22100;
      SetEnv.TERM = "xterm-256color";
      IdentityFile = "~/.ssh/wt_ed25519";
    } // sshTmux;

    settings.revprox_wt = {
      HostName = "hostv2.westminsterteak.com";
      User = "admin";
      Port = 22101;
      SetEnv.TERM = "xterm-256color";
      IdentityFile = "~/.ssh/wt_ed25519";
    } // sshTmux;

    settings.staging_wt = {
      HostName = "hostv2.westminsterteak.com";
      User = "admin";
      Port = 22102;
      SetEnv.TERM = "xterm-256color";
      IdentityFile = "~/.ssh/wt_ed25519";
    } // sshTmux;

    settings.legacy_wt = {
      HostName = "hostv2.westminsterteak.com";
      User = "admin";
      Port = 22103;
      SetEnv.TERM = "xterm-256color";
      IdentityFile = "~/.ssh/wt_ed25519";
    } // sshTmux;
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

  home-manager.users.may.home.stateVersion = "26.05";
}
