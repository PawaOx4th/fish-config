# --------------------------------------------------------- #
### Set fish as a export shell config
# Solve 1
set -Ux STARSHIP_CONFIG ~/.config/fish/starship.toml
# Solve 2
# set --export STARSHIP_CONFIG ~/.config/fish/starship.toml
# --------------------------------------------------------- #

string match -q "$TERM_PROGRAM" "vscode"
and . (code --locate-shell-integration-path fish)


starship init fish | source

fnm env --use-on-cd --shell fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end



# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# pnpm
set -gx PNPM_HOME "/Users/kpc/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
