# fish completion for gsb

complete -c gsb -f

function __gsb_remote_names
    git remote 2>/dev/null
end

function __gsb_remote_names_filtered
    set -l current_token (commandline -ct)

    for remote in (__gsb_remote_names)
        if test -n "$current_token"; and test "$remote" = "$current_token"
            continue
        end
        echo $remote
    end
end

complete -c gsb -s h -l help -d 'Show help message'
complete -c gsb -s f -l fetch -d 'Fetch remote first (blocking)'
complete -c gsb -s a -l auto-fetch -d 'Enable background auto-fetch'
complete -c gsb -l no-auto-fetch -d 'Disable background auto-fetch'
complete -c gsb -l bg-status -d 'Show background fetch status message'
complete -c gsb -l no-bg-status -d 'Hide background fetch status message'

# Suggest git remotes only for the first positional argument.
complete -c gsb -f -n '__fish_is_nth_token 1' -a '(__gsb_remote_names_filtered)' -d 'Git remote'
