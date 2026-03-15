# function gsb --description 'Select a remote branch and switch to it'
#   for arg in $argv
#     switch $arg
#       case --help -h
#         echo "Usage: gsb [remote] [options]"
#         echo ""
#         echo "Select a remote branch with fzf and switch immediately."
#         echo ""
#         echo "Options:"
#         echo "  -h, --help         Show this help message"
#         echo "  -f, --fetch        Fetch remote first (blocking)"
#         echo "  -a, --auto-fetch   Enable background auto-fetch (default)"
#         echo "      --no-auto-fetch Disable background auto-fetch"
#         echo "      --bg-status    Show a short background fetch status message (default)"
#         echo "      --no-bg-status Hide background fetch status message"
#         echo ""
#         echo "Arguments:"
#         echo "  remote             Remote name (default: origin)"
#         echo ""
#         echo "Examples:"
#         echo "  gsb"
#         echo "  gsb upstream"
#         echo "  gsb --fetch"
#         echo "  gsb upstream --no-bg-status"
#         return 0
#     end
#   end

#   if not command -sq git
#     echo "git is not installed"
#     return 1
#   end

#   if not command -sq fzf
#     set_color yellow
#     echo "[gsb warning] fzf is not installed."
#     set_color normal

#     if command -sq brew
#       read -l -P "Install fzf now with Homebrew? [y/N] " install_fzf_confirm
#       switch (string lower -- "$install_fzf_confirm")
#         case y yes
#           if not brew install fzf
#             echo "failed to install fzf via Homebrew"
#             return 1
#           end
#         case '*'
#           echo "skipped installing fzf"
#           return 1
#       end

#       if not command -sq fzf
#         echo "fzf is still not available in PATH. Open a new shell and try again."
#         return 1
#       end
#     else
#       echo "Homebrew is not installed. Install fzf first, then run gsb again."
#       echo "Hint: https://brew.sh"
#       return 1
#     end
#   end

#   if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
#     echo "not inside a git repository"
#     return 1
#   end

#   set -l remote origin
#   set -l should_fetch 0
#   set -l should_auto_fetch 1
#   set -l show_bg_fetch_status 1
#   for arg in $argv
#     switch $arg
#       case --fetch -f
#         set should_fetch 1
#       case --no-auto-fetch
#         set should_auto_fetch 0
#       case --auto-fetch -a
#         set should_auto_fetch 1
#       case --bg-status
#         set show_bg_fetch_status 1
#       case --no-bg-status
#         set show_bg_fetch_status 0
#       case '*'
#         set remote $arg
#     end
#   end

#   if test $should_fetch -eq 1
#     if not git fetch $remote --prune >/dev/null 2>&1
#       echo "failed to fetch remote: $remote"
#       return 1
#     end
#   else if test $should_auto_fetch -eq 1
#     # Run in background so branch list appears immediately.
#     git fetch $remote --prune >/dev/null 2>&1 &
#     disown

#     if test $show_bg_fetch_status -eq 1
#       set_color brblack
#       echo "[gsb] background fetch started for $remote" 1>&2
#       set_color normal
#     end
#   end

#   set -l remote_branches (
#     git for-each-ref --format='%(refname:short)' "refs/remotes/$remote" |
#     string match -rv "$remote/HEAD" |
#     string replace -r "^$remote/" "" |
#     sort -u
#   )

#   if test (count $remote_branches) -eq 0
#     echo "no cached remote branches found for: $remote"
#     echo "try: gsb $remote --fetch"
#     return 1
#   end

#   set -l local_branches (
#     git for-each-ref --format='%(refname:short)' refs/heads |
#     sort -u
#   )

#   set -l selected_line (
#     for branch in $remote_branches
#       if contains -- $branch $local_branches
#         printf '%s\t\033[33m[All]\033[0m: %s\n' $branch $branch
#       else
#         printf '%s\t\033[36m[remote]\033[0m: %s\n' $branch $branch
#       end
#     end |
#     fzf --ansi --height=45% --layout=reverse --prompt="remote branch > " --delimiter='\t' --with-nth=2
#   )

#   set -l selected_parts (string split -m 1 \t -- "$selected_line")
#   set -l selected_branch $selected_parts[1]

#   if test -z "$selected_branch"
#     return 0
#   end

#   if git show-ref --verify --quiet "refs/heads/$selected_branch"
#     git switch $selected_branch
#   else
#     git switch --track -c $selected_branch "$remote/$selected_branch"
#   end
# end
