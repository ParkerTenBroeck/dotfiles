{ pkgs, lib, config, ... }:

let
  hyprOneLine = script:
    "sh -c ${lib.escapeShellArg (lib.concatStringsSep "; " (
      builtins.filter (line: line != "") (
        map lib.trim (lib.splitString "\n" script)
      )
    ))}";

  chromiumX11 = pkgs.symlinkJoin {
    name = "chromium";
    paths = [
      (pkgs.writeShellScriptBin "chromium" ''
        exec ${pkgs.chromium}/bin/chromium --ozone-platform=x11 "$@"
      '')

      (pkgs.makeDesktopItem {
        name = "chromium";
        desktopName = "Chromium";
        genericName = "Web Browser";
        exec = "chromium %U";
        icon = "chromium";
        categories = [ "Network" "WebBrowser" ];
        mimeTypes = [
          "text/html"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
        ];
      })
    ];
  };

  hyprRun = pkgs.writeShellScript "hypr-run-nvidia" ''
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_DESKTOP=Hyprland
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export GBM_BACKEND=nvidia
    export _JAVA_AWT_WM_NONREPARENTING=1
    export XCURSOR_SIZE=24
    export WLR_DRM_DEVICES=$HOME/.config/hypr/card

    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __VK_LAYER_NV_optimus=NVIDIA_only

    exec ${pkgs.hyprland}/bin/Hyprland
  '';
in {
  imports = [
    ./common.nix
    /home/may/Documents/GitHub/mywt/nixos-wt-httpd.nix
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/nvidia.nix
    ../modules/fonts.nix
    ../modules/packages.nix
    ../modules/tex.nix
    ../modules/docker.nix
    ../modules/hyprland
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "work";
  networking.firewall.allowedTCPPorts = [ 5900 8026 25565 42069 8000 8080 ];

  programs.nix-ld.enable = true;

  services.wtLocal = {
    enable = true;
    root = "/home/may/Documents/GitHub/wt";
    user = "may";
    group = "users";
  };

  home-manager.users.may.wayland.windowManager.hyprland.settings.exec-once = lib.mkAfter [
    (hyprOneLine ''
      sleep 2

      hyprctl dispatch exec "[workspace 1 silent] chromium --restore-last-session"

      hyprctl dispatch exec "[workspace 2 silent] code /home/may/Documents/GitHub/wt"
      hyprctl dispatch exec "[workspace 2 silent] alacritty --working-directory /home/may/Documents/GitHub/wt"

      hyprctl dispatch exec "[workspace 2 silent] code /home/may/Documents/GitHub/mywt"
      hyprctl dispatch exec "[workspace 2 silent] alacritty --working-directory /home/may/Documents/GitHub/mywt"

      hyprctl dispatch exec "[workspace 4 silent] firefox"
    '')
  ];

  home-manager.users.may.home.packages = [
    chromiumX11
  ] ++ (with pkgs; [
    docker
    killall
    wayvnc
    wlr-randr
  ]);

  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    XCURSOR_SIZE = "24";

    __NV_PRIME_RENDER_OFFLOAD = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
  };

  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:0:0:0";
  };


  services.greetd = lib.mkIf (config.services.greetd.enable && config.programs.hyprland.enable) {
    settings = {
      initial_session.command = lib.mkForce "${hyprRun}";
      default_session.command =
        lib.mkForce "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${hyprRun}";
    };
  };

  home-manager.users.may.home.stateVersion = "25.11";
}
