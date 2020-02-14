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

function lock
    udisksctl unmount -b /dev/mapper/luks-4223dbef-cc67-4cfe-88db-756ed55ddbcc
    udisksctl lock -b /dev/disk/by-partuuid/92192711-ed9c-4432-b6b6-24c313250abc
end

function unlock
    udisksctl unlock -b /dev/disk/by-partuuid/92192711-ed9c-4432-b6b6-24c313250abc
    udisksctl mount -b /dev/mapper/luks-4223dbef-cc67-4cfe-88db-756ed55ddbcc
end

function import
    echo "You're still in fish!"
end
