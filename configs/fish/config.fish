if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    if test -z $TMUX
        exec tmux
    end
end

fish_add_path $HOME/.local/bin/
fish_add_path $HOME/.cargo/bin/

zoxide init fish | source

alias cd=z
