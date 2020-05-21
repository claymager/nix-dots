set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate 'M'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '?'
set __fish_git_prompt_char_stashstate '«'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'

function fish_mode_prompt --description 'Displays the current mode'
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold red
                echo 🅽
            case insert
                set_color --bold green
                echo 🅸
            case replace_one
                set_color --bold green
                echo 🆁
            case visual
                set_color --bold brmagenta
                echo 🆅
        end
        set_color normal
        printf " "
    end
end

function fish_prompt

  set last_status $status

  if test -n "$SSH_CLIENT"
    set_color yellow
    printf (hostname):
  end

  set_color $fish_color_cwd
  if test $USER = root; set_color red; end
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)

  if test -n "$IN_NIX_SHELL"
    set_color 0ff
    printf "❄ "
  end

  set_color normal
end
