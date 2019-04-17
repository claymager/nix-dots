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

set fish_greeting ""
set -xg BAT_THEME "Dracula"
set -xg NIX_PATH userpkgs=$HOME/nixpkgs:$NIX_PATH

if type -q kitty
    set TERM xterm-color
end
