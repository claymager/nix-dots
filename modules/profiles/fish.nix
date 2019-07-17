{ config, pkgs, lib, ... }:

with lib;
{
  options.profiles.fish.enable = mkEnableOption "fish profile";

  config = mkMerge [
    (mkIf config.profiles.fish.enable {
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
        promptInit = builtins.readFile ./fish/prompt.fish;
        shellInit = builtins.readFile ./fish/init.fish;
        interactiveShellInit = builtins.readFile ./fish/interactive.fish;
        loginShellInit = builtins.readFile ./fish/login.fish;
      };
    })

    (mkIf
      (!builtins.any (p: p == pkgs.kitty) config.environment.systemPackages)
      { environment.variables.TERM = "xterm-color"; }
    )
  ];
}
