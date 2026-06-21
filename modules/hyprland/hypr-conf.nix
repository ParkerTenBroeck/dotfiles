{ lib, ... }:

let
  lua = lib.generators.mkLuaInline;
  toLua = lib.generators.toLua { };

  mod = key: lua ''mainMod .. " + ${key}"'';

  bind = key: dispatcher: {
    _args = [
      key
      (lua dispatcher)
    ];
  };

  bindWith = key: dispatcher: options: {
    _args = [
      key
      (lua dispatcher)
      options
    ];
  };

  exec = command: "hl.dsp.exec_cmd(${toLua command})";
in
{
  home-manager.users.may.wayland.windowManager.hyprland = {
    enable = true;

    configType = "lua";
    xwayland.enable = true;

    package = null;
    portalPackage = null;

    extraConfig = ''
      local config_home = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
      dofile(config_home .. "/hypr/monitors.lua")
    '';

    settings = {
      mainMod = {
        _var = "SUPER";
      };

      config = {
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
          col = {
            active_border = {
              colors = [
                "rgba(ff0000ee)"
                "rgba(ff7f00ee)"
                "rgba(ffff00ee)"
                "rgba(00ff00ee)"
                "rgba(0000ffee)"
                "rgba(9400d3ee)"
              ];
              angle = 45;
            };
            inactive_border = "rgba(595959aa)";
          };
          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
        };

        dwindle = {
          preserve_split = true;
        };

        misc = {
          enable_anr_dialog = false;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          force_default_wallpaper = 0;
        };
      };

      curve = {
        _args = [
          "myBezier"
          {
            type = "bezier";
            points = [
              [
                0.05
                0.9
              ]
              [
                0.1
                1.05
              ]
            ];
          }
        ];
      };

      animation = [
        {
          leaf = "windows";
          enabled = true;
          speed = 7;
          bezier = "myBezier";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 7;
          bezier = "default";
          style = "popin 80%";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "borderangle";
          enabled = true;
          speed = 8;
          bezier = "default";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 7;
          bezier = "default";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 6;
          bezier = "default";
        }
      ];

      gesture = {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      };

      on = [
        {
          _args = [
            "hyprland.start"
            (lua ''
              function()
                hl.exec_cmd("nwg-panel")
                hl.exec_cmd("wl-paste --type text --watch cliphist store")
                hl.exec_cmd("wl-paste --type image --watch cliphist store")
                hl.exec_cmd("nm-applet --indicator")
                hl.exec_cmd("blueman-applet")
                hl.exec_cmd("nwg-drawer -r -nofs")
                hl.exec_cmd("awww-daemon")
                hl.exec_cmd("awww img /home/may/Pictures/background2.jpg")
              end
            '')
          ];
        }
      ];

      bind = [
        (bind (mod "T") (exec "kitty"))
        (bind (mod "B") (exec "firefox"))
        (bind "SUPER + SHIFT + D" "hl.dsp.window.close()")
        (bind "CONTROL + ALT + delete" "hl.dsp.exit()")
        (bind (mod "E") (exec "dolphin"))
        (bind (mod "F") "hl.dsp.window.fullscreen()")
        (bind (mod "M") "hl.dsp.window.fullscreen(1)")
        (bind (mod "V") ''hl.dsp.window.float({ action = "toggle" })'')
        (bind (mod "P") "hl.dsp.window.pseudo()")
        (bind (mod "J") ''hl.dsp.layout("togglesplit")'')
        (bind (mod "C") (exec "hyprpicker --autocopy"))
        (bind "Print" (exec "grimblast --freeze copysave area - | swappy -f -"))
        (bind (mod "1") "hl.dsp.focus({ workspace = 1 })")
        (bind (mod "2") "hl.dsp.focus({ workspace = 2 })")
        (bind (mod "3") "hl.dsp.focus({ workspace = 3 })")
        (bind (mod "4") "hl.dsp.focus({ workspace = 4 })")
        (bind (mod "5") "hl.dsp.focus({ workspace = 5 })")
        (bind (mod "6") "hl.dsp.focus({ workspace = 6 })")
        (bind (mod "7") "hl.dsp.focus({ workspace = 7 })")
        (bind (mod "8") "hl.dsp.focus({ workspace = 8 })")
        (bind (mod "9") "hl.dsp.focus({ workspace = 9 })")
        (bind (mod "0") "hl.dsp.focus({ workspace = 10 })")
        (bind (mod "SHIFT + 1") "hl.dsp.window.move({ workspace = 1 })")
        (bind (mod "SHIFT + 2") "hl.dsp.window.move({ workspace = 2 })")
        (bind (mod "SHIFT + 3") "hl.dsp.window.move({ workspace = 3 })")
        (bind (mod "SHIFT + 4") "hl.dsp.window.move({ workspace = 4 })")
        (bind (mod "SHIFT + 5") "hl.dsp.window.move({ workspace = 5 })")
        (bind (mod "SHIFT + 6") "hl.dsp.window.move({ workspace = 6 })")
        (bind (mod "SHIFT + 7") "hl.dsp.window.move({ workspace = 7 })")
        (bind (mod "SHIFT + 8") "hl.dsp.window.move({ workspace = 8 })")
        (bind (mod "SHIFT + 9") "hl.dsp.window.move({ workspace = 9 })")
        (bind (mod "SHIFT + 0") "hl.dsp.window.move({ workspace = 10 })")
        (bind (mod "mouse_down") ''hl.dsp.focus({ workspace = "e+1" })'')
        (bind (mod "mouse_up") ''hl.dsp.focus({ workspace = "e-1" })'')
        (bind (mod "left") ''hl.dsp.focus({ direction = "left" })'')
        (bind (mod "right") ''hl.dsp.focus({ direction = "right" })'')
        (bind (mod "up") ''hl.dsp.focus({ direction = "up" })'')
        (bind (mod "down") ''hl.dsp.focus({ direction = "down" })'')
        (bind (mod "SHIFT + left") ''hl.dsp.window.move({ direction = "left" })'')
        (bind (mod "SHIFT + right") ''hl.dsp.window.move({ direction = "right" })'')
        (bind (mod "SHIFT + up") ''hl.dsp.window.move({ direction = "up" })'')
        (bind (mod "SHIFT + down") ''hl.dsp.window.move({ direction = "down" })'')
        (bindWith "SUPER + SUPER_L" (exec "nwg-drawer -nofs") { release = true; })
        (bindWith (mod "mouse:272") "hl.dsp.window.drag()" { mouse = true; })
        (bindWith (mod "mouse:273") "hl.dsp.window.resize()" { mouse = true; })
        (bindWith (mod "ALT + left") ''hl.dsp.window.resize({ x = -10, y = 0, relative = true })'' { repeating = true; })
        (bindWith (mod "ALT + right") ''hl.dsp.window.resize({ x = 10, y = 0, relative = true })'' { repeating = true; })
        (bindWith (mod "ALT + up") ''hl.dsp.window.resize({ x = 0, y = -10, relative = true })'' { repeating = true; })
        (bindWith (mod "ALT + down") ''hl.dsp.window.resize({ x = 0, y = 10, relative = true })'' { repeating = true; })
        (bindWith "XF86AudioRaiseVolume" (exec "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%+") { repeating = true; })
        (bindWith "XF86AudioLowerVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-") { repeating = true; })
        (bindWith "XF86MonBrightnessUp" (exec "brightnessctl s +5%") { repeating = true; })
        (bindWith "XF86MonBrightnessDown" (exec "brightnessctl s 5%-") { repeating = true; })
        (bindWith "XF86AudioMute" (exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") { locked = true; })
        (bindWith "XF86AudioPlay" (exec "playerctl play-pause") { locked = true; })
        (bindWith "XF86AudioNext" (exec "playerctl next") { locked = true; })
        (bindWith "XF86AudioPrev" (exec "playerctl previous") { locked = true; })
        (bindWith "XF86Search" (exec "launchpad") { locked = true; repeating = true; })
      ];
    };
  };
}
