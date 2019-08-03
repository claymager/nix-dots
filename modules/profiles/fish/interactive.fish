function haskellEnv
  nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $argv ])"
end

function pythonEnv --description 'start a nix-shell with the given python packages' --argument pythonVersion
  if set -q argv[2]
    set argv $argv[2..-1]
  else
    set -e argv
  end
  nix-shell -p "python$pythonVersion.withPackages (ps: with ps; [ $argv ipython ])"
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
