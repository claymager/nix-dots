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
abbr npss nixops ssh-for-each -d
abbr npa nixops info --all
abbr npl nixops list

abbr jn 'jupyter-notebook ^ /dev/null > /dev/null &'


abbr icat kitty +kitten icat

abbr g git
abbr glo git log --graph --oneline
abbr gla git log --graph --oneline --all
abbr gl git log
abbr gco git checkout

abbr udm udisksctl mount -b
abbr udu udisksctl unmount -b

set -u fish_color_autosuggestion 'BD93F9'
set -u fish_color_cancel '-r'
set -u fish_color_command 'F8F8F2'
set -u fish_color_comment '6272A4'
set -u fish_color_cwd 'green'
set -u fish_color_cwd_root 'red'
set -u fish_color_end '50FA7B'
set -u fish_color_error 'FFB86C'
set -u fish_color_escape '00a6b2'
set -u fish_color_history_current '--bold'
set -u fish_color_host 'normal'
set -u fish_color_match '--background=brblue'
set -u fish_color_normal 'normal'
set -u fish_color_operator '00a6b2'
set -u fish_color_param 'FF79C6'
set -u fish_color_quote 'F1FA8C'
set -u fish_color_redirection '8BE9FD'
set -u fish_color_search_match 'bryellow --background=brblack'
set -u fish_color_selection 'white --bold --background=brblack'
set -u fish_color_status 'red'
set -u fish_color_user 'brgreen'
set -u fish_color_valid_path '--underline'
set -u fish_key_bindings 'fish_default_key_bindings'
set -u fish_pager_color_completion 'normal'
set -u fish_pager_color_description 'B3A06D yellow'
set -u fish_pager_color_prefix 'white --bold --underline'
set -u fish_pager_color_progress 'brwhite --background=cyan'
