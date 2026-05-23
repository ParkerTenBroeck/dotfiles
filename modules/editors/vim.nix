{
  home-manager.users.may = {
    programs.vim = {
      enable = true;
      extraConfig = builtins.readFile ./shared.vim;
    };
  };
}
