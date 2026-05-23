{ pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.variables.NIX_BUILD_SHELL = "${pkgs.zsh}/bin/zsh";

  home-manager.users.may = { pkgs, ... }: {
    home.file.".p10k.zsh".source = ./.p10k.zsh;

    home.packages = with pkgs; [ hstr ];

    programs.zsh = {
      enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" "history-substring-search" ];
      };

      initContent = ''
        source "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
        source ~/.p10k.zsh

        # HSTR configuration - add this to ~/.zshrc
        alias hh=hstr                    # hh to be alias for hstr
        setopt histignorespace           # skip cmds w/ leading space from history
        export HSTR_CONFIG=hicolor       # get more colors
        hstr_no_tiocsti() {
            zle -I
            { HSTR_OUT="$( { </dev/tty hstr ''${BUFFER}; } 2>&1 1>&3 3>&- )"; } 3>&1;
            BUFFER="''${HSTR_OUT}"
            CURSOR=''${#BUFFER}
            zle redisplay
        }
        zle -N hstr_no_tiocsti
        bindkey '\C-r' hstr_no_tiocsti
        export HSTR_TIOCSTI=n
      '';

      shellAliases = {
        ll = "ls -lah";
        update = "sudo nixos-rebuild switch";
      };

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
