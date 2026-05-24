{ pkgs, ...}: {
  imports = [
    ./common.nix
    ../modules/networking.nix
    ../modules/bluetooth.nix
    ../modules/games/steam.nix
    ../modules/games/minecraft.nix
    ../modules/fonts.nix
    ../modules/packages.nix
    ../modules/hyprland
    ../modules/tex.nix
    ../modules/virt.nix
    ../modules/arduino.nix
    ../../perf_mode/perf_mode.nix
  ];

  nixpkgs.config.allowUnfree = true;

  services.perf_mode.enable = true;

  networking.hostName = "laptop";

  services.logind.settings.Login.HandlePowerKey = "hibernate";

  # stupid ISO keyboards
  console.useXkbConfig = true;
  services.xserver.xkb = {
    variant = "";

    layout = "us-custom";
    extraLayouts.us-custom = {
      description = "My custom US layout";
      languages = [ "eng" ];

      symbolsFile = pkgs.writeText "xkb-layout" ''
        xkb_symbols "us-custom" {
          include "us(basic)"
          include "level3(ralt_switch)"
          key <LSGT> { [ Shift_L ] };
       };
      '';
    };
  };

  home-manager.users.may.home.packages = with pkgs; [ 
    intel-gpu-tools
    obsidian
    chromium
    libreoffice
  ];

  networking.firewall = {
   allowedTCPPorts = [
      #web
      8000
      8080

      42069
    ];

    allowedUDPPorts = [
      #spotify google cast
      5353
    ];
  };

  home-manager.users.may.home.stateVersion = "25.11";
}
