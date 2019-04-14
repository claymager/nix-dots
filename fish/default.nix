{ config, pkgs, ... }:

{
  environment = {
    variables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      l = "ls -XlhGgo --color=auto";
      t = "tree --filelimit 30 -ClL 3";
      neo = "nvim";
      to = "todo.sh";
      ns = "nix-shell --command \"exec fish\"";
      nxt = "nixos-rebuild test";
      nxf = "nixos-rebuild test --fast";
      nxc = "sudo nixos-container";
    };
  };

  programs.fish = {
    enable = true;
    promptInit = builtins.readFile ./prompt.fish;
    shellInit  = builtins.readFile ./functions.fish;
  };
}
