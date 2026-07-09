function fish_prompt
    #Set the time and date.
    set -l time "$(set_color cyan)$(date +%a) $(date +%b-'%m') $(set_color blue)$(date +'%-I':%M:%S%P)"

    # Set the exit status, given that the exit status is not 0.
    set -l last_status $status
    set -l stat
    if test $last_status -ne 0
        set stat (set_color brred)"[$last_status]"
    end

    # Constructs the cpu string (by far the most complicated.
    set -l cpu (grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' | awk '{printf("%.1f\n", $1)}')
    set -l cpustring "$(set_color magenta)CPU $cpu%"
    set -l job_count (set_color magenta)(count (jobs))
    set -l net (set_color magenta)"Net $(awk 'END {print NR}' /proc/net/tcp)"
    set -l usage_string "$cpustring$(set_color normal):$job_count$(set_color normal):$net"

    # Lists the current directory statistics
    set -l file_count (set_color green)"$(/usr/bin/ls -A -1 | wc -l)"
    set -l file_size (set_color green)"$(/usr/bin/ls -lah | /usr/bin/grep -m 1 total | sed 's/total //')"

    string join - -- (surround $time) (surround $usage_string) (surround (set_color red)$USER:(set_color yellow)(prompt_pwd -D 2)) (surround $file_size(set_color normal):$file_count) $stat
    echo (set_color green)'> '
end
