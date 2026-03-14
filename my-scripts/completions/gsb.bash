# bash completion for gsb
_gsb_completion() {
  local cur prev opts remotes
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  opts="-h --help -f --fetch -a --auto-fetch --no-auto-fetch --bg-status --no-bg-status"

  # If the previous token is an option, only complete options.
  case "$prev" in
    -h|--help|-f|--fetch|-a|--auto-fetch|--no-auto-fetch|--bg-status|--no-bg-status)
      COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
      return 0
      ;;
  esac

  remotes="$(git remote 2>/dev/null)"

  if [[ "$cur" == -* ]]; then
    COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
  else
    COMPREPLY=( $(compgen -W "$remotes $opts" -- "$cur") )
  fi
}

complete -F _gsb_completion gsb
