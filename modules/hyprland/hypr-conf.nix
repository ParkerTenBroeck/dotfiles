{
  home-manager.users.may.wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;

    package = null;
    portalPackage = null;

    settings = {
      "$mainMod" = "SUPER";

      source = "~/.config/hypr/monitors.conf";

      env = [];

      exec-once = [
        "nwg-panel"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "nm-applet --indicator"
        "blueman-applet"
        "nwg-drawer -r -nofs"
        "swww-daemon"
      ];

      exec = [
        "swww img /home/may/Pictures/background2.jpg"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        # sensitivity = 0.7;
        # accel_profile = "flat";

        touchpad = {
          natural_scroll = true;
        };
      };

      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 3;
        "col.active_border" = "rgba(ff0000ee) rgba(ff7f00ee) rgba(ffff00ee) rgba(00ff00ee) rgba(0000ffee) rgba(9400d3ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      gestures = {
        gesture = "3, horizontal, workspace";
      };

      "device:epic-mouse-v1" = {
      };

      misc = {
        enable_anr_dialog = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      bind = [
        "$mainMod, T, exec, alacritty"
        "$mainMod, B, exec, firefox"
        "SUPER_SHIFT, D, killactive,"
        "CONTROL_ALT, delete, exit,"
        "$mainMod, E, exec, nautilus"
        "$mainMod, F, fullscreen,"
        "$mainMod, M, fullscreen, 1"
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, C, exec, hyprpicker --autocopy"
        ", Print, exec, grimblast --freeze copysave area - | swappy -f -"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
      ];

      bindr = [
        "SUPER, SUPER_L, exec, nwg-drawer -nofs"
      ];

      binde = [
        "$mainMod ALT, left, resizeactive, -10 0"
        "$mainMod ALT, right, resizeactive, 10 0"
        "$mainMod ALT, up, resizeactive, 0 -10"
        "$mainMod ALT, down, resizeactive, 0 10"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindle = [
        ", XF86Search, exec, launchpad"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
