{ pkgs, lib, config, ... }:

let
  sshTmux = {
    # RequestTTY = "force";
    # RemoteCommand = "[[ $- != *i* ]] && return; tmux new-session -A -s parker";
  };
in {
  imports = [
    ./common.nix
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/fonts.nix
    ../modules/packages.nix
    # ../modules/tex.nix
    ../modules/docker.nix
    ../modules/kde
    ../modules/nvidia.nix
  ];


   networking.extraHosts = ''
      127.0.0.1 wt.com www.wt.com wt.com
      ::1 wt.com www.wt.com wt.com    
  '';

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;
  users.users.may.extraGroups = [ "docker" ];

  networking.hostName = "work";
  networking.firewall.allowedTCPPorts = [ 5900 8026 25565 42069 8000 8080 9003 ];

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

    settings.testing_wt = {
      HostName = "hostv2.westminsterteak.com";
      User = "admin";
      Port = 22104;
      SetEnv.TERM = "xterm-256color";
      IdentityFile = "~/.ssh/wt_ed25519";
    } // sshTmux;
  };



  home-manager.users.may.home.packages = with pkgs; [
    chromium
    docker
    killall
    wayvnc
    wlr-randr
  ];

  home-manager.users.may.home.stateVersion = "26.11";
}
