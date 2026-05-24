{ pkgs, ...}: {
  home-manager.users.may = {
    home.packages = with pkgs; [ 
      git
      gitui
      # yes I'm a baby I know
      gh
    ];

    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Parker TenBroeck";
          email = "51721964+ParkerTenBroeck@users.noreply.github.com";
        };
        
        credential."https://github.com" = {
          helper = "!${pkgs.gh}/bin/gh auth git-credential";
        };

        credential."https://gist.github.com" = {
          helper = "!${pkgs.gh}/bin/gh auth git-credential";
        };

        filter.lfs = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
          required = true;
        };

        pull.ff = true;
      };
    };
  };
}