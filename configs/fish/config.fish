if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    if test -z $TMUX
        exec tmux
    end
end
