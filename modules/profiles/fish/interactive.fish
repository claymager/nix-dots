function haskellEnv
  nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $argv ])" --command "exec fish; return"
end

function pythonEnv --description 'start a nix-shell with the given python packages' --argument pythonVersion
  if set -q argv[2]
    set argv $argv[2..-1]
  end
  for el in $argv ipython
    set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
  end
  nix-shell -p $ppkgs --command "exec fish; return"
end

function nixos-rebuild
    set cmd (which nixos-rebuild)
    sudo $cmd $argv
    unlink result
end

function nix-shell
    set cmd (which nix-shell)
    $cmd --command "exec fish" $argv
end
