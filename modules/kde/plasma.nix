{

  xdg.dataFile = {
    "aurorae/themes/BorderOnly/metadata.desktop".source =
      ./window-decoration/metadata.desktop;
    "aurorae/themes/BorderOnly/BorderOnlyrc".source =
      ./window-decoration/BorderOnlyrc;
    "aurorae/themes/BorderOnly/decoration.svg".source =
      ./window-decoration/decoration.svg;

    "kwin/scripts/follow-moved-window-to-desktop/contents/code/main.js".source =
      ./follow-moved-window-to-desktop.js;

    "kwin/scripts/follow-moved-window-to-desktop/metadata.json".text = builtins.toJSON {
      KPackageStructure = "KWin/Script";
      KPlugin = {
        Id = "follow-moved-window-to-desktop";
        Name = "Follow Moved Window to Desktop";
        Description = "Switches to the virtual desktop a window was moved to.";
        Icon = "preferences-system-windows-script-test";
        License = "GPL";
      };
      "X-Plasma-API" = "javascript";
    };
  };

  programs.plasma = {
    enable = true;

    workspace = {
      colorScheme = "BreezeDark";
      cursor = {
        theme = "Adwaita";
        size = 24;
      };
      iconTheme = "breeze-dark";
      theme = "breeze-dark";
      widgetStyle = "Breeze";
      windowDecorations = {
        library = "org.kde.kwin.aurorae.v2";
        theme = "__aurorae__svg__BorderOnly";
      };
    };

    input.keyboard = {
      repeatDelay = 600;
      repeatRate = 25;
    };

    input.touchpads = [
      {
        name = "SynPS/2 Synaptics TouchPad";
        vendorId = "0002";
        productId = "0007";
        naturalScroll = true;
      }
    ];

    krunner.shortcuts.launch = [
      "Meta"
      "Alt+Space"
      "Alt+F2"
      "Search"
    ];

    powerdevil.AC.autoSuspend.action = "nothing";

    kscreenlocker = {
      autoLock = true;
      lockOnResume = true;
    };

    panels = [
      {
        location = "top";
        # this is stupid "all" doesn't work because of course
        screen = [ 0 1 2 3 ];
        widgets = [
          "org.kde.plasma.kickoff"
          {
            pager.general = {
              displayedText = "desktopName";
              showWindowOutlines = false;
              showApplicationIconsOnWindowOutlines = false;
            };
          }
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          {
            digitalClock.time.format = "24h";
          }
        ];
      }
    ];

    kwin = {
      virtualDesktops = {
        number = 10;
        rows = 2;
        names = [
          "1"
          "2"
          "3"
          "4"
          "5"
          "6"
          "7"
          "8"
          "9"
          "10"
        ];
      };

      effects.desktopSwitching.navigationWrapping = false;

      tiling.padding = 16;
    };

    hotkeys.commands = {
      launch-kitty = {
        name = "Kitty";
        key = "Meta+T";
        command = "kitty";
        logs.enabled = false;
      };

      launch-firefox = {
        name = "Firefox";
        key = "Meta+B";
        command = "firefox";
        logs.enabled = false;
      };

      launch-dolphin = {
        name = "Files";
        key = "Meta+E";
        command = "dolphin";
        logs.enabled = false;
      };

      launch-color-picker = {
        name = "Color Picker";
        key = "Meta+C";
        command = "kcolorchooser";
        logs.enabled = false;
      };

    };

    shortcuts = {
      kwin = {
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Switch to Desktop 10" = "Meta+0";

        "Window to Desktop 1" = "none";
        "Window to Desktop 2" = "none";
        "Window to Desktop 3" = "none";
        "Window to Desktop 4" = "none";
        "Window to Desktop 5" = "none";
        "Window to Desktop 6" = "none";
        "Window to Desktop 7" = "none";
        "Window to Desktop 8" = "none";
        "Window to Desktop 9" = "none";
        "Window to Desktop 10" = "none";

        KrohnkiteFocusLeft = "Meta+Left";
        KrohnkiteFocusRight = "Meta+Right";
        KrohnkiteFocusUp = "Meta+Up";
        KrohnkiteFocusDown = "Meta+Down";
        "Switch Window Left" = "none";
        "Switch Window Right" = "none";
        "Switch Window Up" = "none";
        "Switch Window Down" = "none";

        KrohnkiteShiftLeft = "Meta+Shift+Left";
        KrohnkiteShiftRight = "Meta+Shift+Right";
        KrohnkiteShiftUp = "Meta+Shift+Up";
        KrohnkiteShiftDown = "Meta+Shift+Down";
        "Window Quick Tile Left" = "none";
        "Window Quick Tile Right" = "none";
        "Window Quick Tile Top" = "none";
        "Window Quick Tile Bottom" = "none";

        KrohnkiteShrinkWidth = "Meta+Alt+Left";
        KrohnkitegrowWidth = "Meta+Alt+Right";
        KrohnkiteShrinkHeight = "Meta+Alt+Up";
        KrohnkiteGrowHeight = "Meta+Alt+Down";

        "Switch to Next Desktop" = "Meta+WheelDown";
        "Switch to Previous Desktop" = "Meta+WheelUp";

        KrohnkiteMonocleLayout = "Meta+M";

        KrohnkiteRotate = "Meta+K";
        KrohnkiteToggleFloat = "Meta+V";

        "Window Close" = "Meta+Shift+D";
        "Window Fullscreen" = "Meta+F";
        "Window Maximize" = "none";
        "Window Operations Menu" = "none";
        "Window Move" = "none";
        "Window Resize" = "none";
      };

      ksmserver."Log Out" = "Ctrl+Alt+Del";

      plasmashell."activate application launcher" = "none";

      kmix = {
        increase_volume = "Volume Up";
        decrease_volume = "Volume Down";
        mute = "Volume Mute";
      };

      mediacontrol = {
        playpausemedia = "Media Play";
        nextmedia = "Media Next";
        previousmedia = "Media Previous";
      };
    };

    configFile = {
      kwinrc = {
        "Effect-overview".BorderActivate = 9;

        "Script-krohnkite" = {
          adjustLayout = true;
          adjustLayoutLive = true;
          directionalKeyDwm = false;
          directionalKeyFocus = true;
          floatUtility = true;
          keepTilingOnDrag = true;
          layoutPerDesktop = true;
          monocleMaximize = false;
          newWindowPosition = 0;
          noTileBorder = false;

          screenGapBottom = 4;
          screenGapBetween = 4;
          screenGapLeft = 4;
          screenGapRight = 4;
          screenGapTop = 4;

          soleWindowNoBorders = false;
          soleWindowNoGaps = false;
          notificationDuration = 0;
          columnsLayoutOrder = 1;
          tileLayoutOrder = 7;
          floatingLayoutOrder = 9;
          binaryTreeLayoutOrder = 11;
        };

        MouseBindings = {
          CommandAllKey = "Meta";
          CommandAll1 = "Activate, raise and move";
          CommandAll3 = "Resize";
        };

        Plugins = {
          desktopchangeosdEnabled = true;
          "follow-moved-window-to-desktopEnabled" = true;
          krohnkiteEnabled = true;
        };
        TabBox.HighlightWindows = true;

        Windows = {
          ActiveMouseScreen = true;
          ActivationDesktopPolicy = "SwitchToOtherDesktop";
          BorderSnapZone = 10;
          CenterSnapZone = 0;
          DelayFocusInterval = 0;
          FocusPolicy = "FocusFollowsMouse";
          # Keep a single keyboard-focus target across screens so KWin shortcuts
          # act on the window under the pointer without requiring a click first.
          SeparateScreenFocus = false;
          GeometryTip = false;
          PerOutputVirtualDesktops = true;
          WindowSnapZone = 10;
        };

        "org.kde.kdecoration2" = {
          BorderSize = "Tiny";
          BorderSizeAuto = false;
        };
      };

      kdeglobals.General = {
        Name = "Breeze Dark";
        TerminalApplication = "kitty";
        TerminalService = "kitty.desktop";
      };

      "plasma-localerc" = {
        Formats = {
          LANG = "en_CA.UTF-8";
          LC_MEASUREMENT = "en_CA.UTF-8";
        };
        Translations.LANGUAGE = "en_GB.UTF-8";
      };
    };
  };
}
