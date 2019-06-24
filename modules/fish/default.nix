{ config, pkgs, ... }:

{
  environment = {
    variables = {
      EDITOR = "nvim";
      SYSTEMD_COLORS = "1";
    };
    shellAliases = {
      watch = "watch -c";
      ip = "ip -c=always";
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
