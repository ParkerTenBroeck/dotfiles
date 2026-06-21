{ pkgs, ...}: let
  # nixpkgs master Plasma 6.7.0. 
  plasmaNixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/a6dd75750046a77baa093c1f3cc606b1c53053c9.tar.gz";
    sha256 = "1wq2wibvn41d6ynpfxc5v4kpl49p5j4spb816h36iddql54kbcy2";
  };
in {
  nixpkgs.overlays = [
    (_final: stable: {
      kdePackages = (import plasmaNixpkgs {
        inherit (stable.stdenv.hostPlatform) system;
      }).kdePackages;
    })
  ];

  imports = [
    # assume any desktop env will have audio
    ../audio.nix
    ../gui.nix
  ];

  home-manager.sharedModules = [
    <plasma-manager/modules>
  ];

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
  ];
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];


  programs.dconf.enable = true;
  security.polkit.enable = true;

  home-manager.users.may = { config, pkgs, ... }: {
    imports = [
      ./plasma.nix
    ];

    gtk = {
      enable = true;

      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };

      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };

      gtk2 = {
        enable = false;
        extraConfig = null;
      };
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    };

    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };

    home.pointerCursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
      gtk.enable = true;
    };

    home.packages = with pkgs; [
      brightnessctl
      kdePackages.dolphin
      kdePackages.kcolorchooser
      playerctl
      pavucontrol
    ];

  };
}
