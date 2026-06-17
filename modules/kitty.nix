{
  home-manager.users.may.programs.kitty = {
    enable = true;
 
    shellIntegration.enableZshIntegration = true;

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      cursor_trail = "1";
      cursor_trail_decay = "0.15 0.3";
      cursor_trail_start_threashold = "2";
      mouse_hide_wait = "2.0";

      strip_trailing_spaces = "always";
    };
  };
}
