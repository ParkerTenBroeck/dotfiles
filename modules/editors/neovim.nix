{
  home-manager.users.may = {
    programs.neovim = {
      enable = true;
      viAlias = true;
      defaultEditor = true;
      extraConfig = builtins.readFile ./shared.vim;
    };
  };
}
