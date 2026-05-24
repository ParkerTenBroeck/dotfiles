{ config, lib, pkgs, ... }:

let
  hyprRun = pkgs.writeShellScript "hypr-run" ''
    exec ${pkgs.hyprland}/bin/Hyprland
  '';
in {
  imports = [
    ./hypr-conf.nix
    ./nwg-panel-conf.nix
    # assume any desktop env will have audio
    ../audio.nix
    ../gui.nix
  ];

  
  programs.dconf.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];

  programs.hyprland.enable = true;

  services.displayManager.gdm.enable = lib.mkForce false;

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${hyprRun}";
        user = "may";
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${hyprRun}";
        user = "greeter";
      };
    };
  };

  home-manager.users.may = { pkgs, ... }: {
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

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "Adwaita-dark";
      };
    };

    home.pointerCursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
      gtk.enable = true;
    };

    home.packages = with pkgs; [
      # notifications
      libnotify
      dunst

      # applets
      networkmanagerapplet
      blueman
      brightnessctl

      # screenshot + editor
      grim
      grimblast
      swappy
      slurp

      # GUI sound control
      pavucontrol 

      # clipboard
      wl-clipboard
      nwg-clipman
      cliphist

      # nwg utilities
      nwg-displays # GUI display setup
      nwg-look     # GUI theme settings
      nwg-drawer   # application drawer (super key)
      nwg-panel    # top bar

      # wallpaper
      swww

      # media controls
      playerctl

      hyprpaper
      hyprpicker
      hyprsysteminfo
      hyprpwcenter
      hyprgraphics
    ];
  };
}
