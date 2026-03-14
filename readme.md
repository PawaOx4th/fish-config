Fish Config Notes

Portable gsb command

File location:

- my-scripts/gsb

What it does:

- Select a remote branch and switch immediately.
- Works in any POSIX shell (sh, bash, zsh, fish).
- Uses fzf when available, and falls back to a numbered menu when fzf is missing.

Quick setup on any machine:

1. Copy this repo (or just my-scripts/gsb) to your machine.
2. Make executable:
   chmod +x ~/.config/fish/my-scripts/gsb
3. Put it in PATH, for example:
   mkdir -p ~/.local/bin
   ln -sf ~/.config/fish/my-scripts/gsb ~/.local/bin/gsb
4. Ensure ~/.local/bin is in PATH for your shell.

Usage:

- gsb
- gsb upstream
- gsb --fetch
- gsb upstream --no-bg-status

Enable bash completion:

1. Add this line to ~/.bashrc
   source ~/.config/fish/my-scripts/completions/gsb.bash
2. Reload shell
   source ~/.bashrc

Enable zsh completion:

1. Add this line to ~/.zshrc
   fpath=(~/.config/fish/my-scripts/completions $fpath)
2. Make sure compinit is enabled in ~/.zshrc
   autoload -Uz compinit && compinit
3. Reload shell
   source ~/.zshrc

Enable fish completion:

1. Completion file is already at ~/.config/fish/completions/gsb.fish
2. Reload fish
   source ~/.config/fish/completions/gsb.fish
