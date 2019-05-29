if type -q kitty
    set TERM xterm-color
end

# Clear previous abbreviations
for a in (abbr -l)
    abbr -e $a
end

abbr ta 'todo.sh add "(A)'
abbr tb 'todo.sh add "(B)'
abbr tc 'todo.sh add "(C)'
abbr tg todo.sh again

abbr n nvim
abbr mv mv -i
abbr cp cp -i

abbr ns nix-shell
abbr nsp nix-shell -p
abbr nxt nixos-rebuild test
abbr nxf nixos-rebuild test --fast
abbr nxs nixos-rebuild switch

abbr no nixos-option

abbr nxc sudo nixos-container
abbr np nixops
abbr npe nixops edit -d
abbr npd nixops destroy -d
abbr npp nixops deploy -d
abbr npi nixops info -d
abbr nps nixops ssh -d
abbr npa nixops info --all

abbr jn 'jupyter-notebook ^ /dev/null > /dev/null &'


abbr icat kitty +kitten icat

abbr g git
abbr glo git log --graph --oneline
abbr gla git log --graph --oneline --all
abbr gl git log 
abbr gco git checkout

abbr udm udisksctl mount -b
abbr udu udisksctl unmount -b
