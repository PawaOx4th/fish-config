# fish completion for gsb

function __gsb_remote_names
    git remote 2>/dev/null
end

complete -c gsb -s h -l help -d 'Show help message'
complete -c gsb -s f -l fetch -d 'Fetch remote first (blocking)'
complete -c gsb -s a -l auto-fetch -d 'Enable background auto-fetch'
complete -c gsb -l no-auto-fetch -d 'Disable background auto-fetch'
complete -c gsb -l bg-status -d 'Show background fetch status message'
complete -c gsb -l no-bg-status -d 'Hide background fetch status message'

# Suggest git remotes as positional argument.
complete -c gsb -f -a '(__gsb_remote_names)' -d 'Git remote'
