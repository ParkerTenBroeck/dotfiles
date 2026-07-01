{ pkgs, ...}: {

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
      kdePackages.krohnkite
      playerctl
      pavucontrol
    ];

  };
}
