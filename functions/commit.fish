function commit
    set mode $argv[1]
    echo "Mode: $mode"

    if test "$mode" = url
        commit_url
    else if test "$mode" = id
        commit-id
    else
        echo "Usage: commit [url|id]"
    end
end
