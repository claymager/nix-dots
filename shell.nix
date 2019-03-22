{ config, pkgs, ... }:

{
  environment = {
    variables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      l = "ls -XlhGgo --color=auto";
      t = "tree --filelimit 30 -ClL 3";
      vi = "nvim";
      neo = "nvim";
      to = "todo.sh";
      nix-shell = "nix-shell --command \"exec fish\"";
    };
  };

  programs.fish = {
    enable = true;
    promptInit = ''
      set normal (set_color normal)
      set magenta (set_color magenta)
      set yellow (set_color yellow)
      set green (set_color green)
      set red (set_color red)
      set gray (set_color -o black)

      # Fish git prompt
      set __fish_git_prompt_showdirtystate 'yes'
      set __fish_git_prompt_showstashstate 'yes'
      set __fish_git_prompt_showuntrackedfiles 'yes'
      set __fish_git_prompt_showupstream 'yes'
      set __fish_git_prompt_color_branch yellow
      set __fish_git_prompt_color_upstream_ahead green
      set __fish_git_prompt_color_upstream_behind red

      # Status Chars
      set __fish_git_prompt_char_dirtystate 'M'
      set __fish_git_prompt_char_stagedstate '→'
      set __fish_git_prompt_char_untrackedfiles '?'
      set __fish_git_prompt_char_stashstate '«'
      set __fish_git_prompt_char_upstream_ahead '+'
      set __fish_git_prompt_char_upstream_behind '-'

      function fish_prompt

        set last_status $status

        if test -n "$SSH_CLIENT"
          set_color yellow
          printf (hostname):
        end

        set_color $fish_color_cwd
        printf '%s' (prompt_pwd)
        set_color normal

        printf '%s ' (__fish_git_prompt)

        if test -n "$IN_NIX_SHELL"
          set_color 0ff
          printf "❄ "
        end

        set_color normal
      end
    '';

    shellInit = ''
      function haskellEnv
        nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $argv ])"
      end

      function pythonEnv --description 'start a nix-shell with the given python packages' --argument pythonVersion
        if set -q argv[2]
          set argv $argv[2..-1]
        end
        for el in $argv ipython
          set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
        end
        nix-shell -p $ppkgs
      end

      function nixos-rebuild
        sudo nixos-rebuild $argv
        unlink result
      end

      set fish_greeting ""
      set -xg BAT_THEME "Dracula"
      set -xg NIX_PATH userpkgs=$HOME/nixpkgs:$NIX_PATH

      '';
  };
}
