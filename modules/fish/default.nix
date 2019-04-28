{ config, pkgs, ... }:

{
  environment = {
    variables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      l = "ls -XlhGgo --color=auto";
      t = "tree --filelimit 30 -ClL 3";
    };
  };

  programs.fish = {
    enable = true;
    promptInit = builtins.readFile ./prompt.fish;
    shellInit = builtins.readFile ./init.fish;
    interactiveShellInit = builtins.readFile ./interactive.fish;
    loginShellInit  = builtins.readFile ./login.fish;
  };
}
