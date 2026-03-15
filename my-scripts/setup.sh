#!/bin/bash
# ============================================================
# setup.sh — Install carapace & starship
# ============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# ── Homebrew ─────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  info "Homebrew already installed: $(brew --version | head -1)"
fi

# ── Starship ─────────────────────────────────────────────────
if command -v starship &>/dev/null; then
  warn "Starship already installed: $(starship --version | head -1)"
else
  info "Installing Starship..."
  brew install starship
  info "Starship installed: $(starship --version | head -1)"
fi

# ── Carapace ─────────────────────────────────────────────────
if command -v carapace &>/dev/null; then
  warn "Carapace already installed: $(carapace --version)"
else
  info "Installing Carapace..."
  brew install carapace
  info "Carapace installed: $(carapace --version)"
fi

# ── Starship config ──────────────────────────────────────────
STARSHIP_CONFIG="$HOME/.config/fish/starship.toml"
if [ -f "$STARSHIP_CONFIG" ]; then
  info "Starship config already exists: $STARSHIP_CONFIG"
else
  warn "No starship.toml found — creating default config at $STARSHIP_CONFIG"
  mkdir -p "$(dirname "$STARSHIP_CONFIG")"
  cat > "$STARSHIP_CONFIG" <<'EOF'
"$schema" = 'https://starship.rs/config-schema.json'

format = '$time$all$character'
command_timeout = 100000

[git_status]
ahead = '⇡${count}'
diverged = '⇕⇡${ahead_count}⇣${behind_count}'
behind = '⇣${count}'

[git_metrics]
added_style = 'bold blue'
format = '[+$added]($added_style)/[-$deleted]($deleted_style) '

[time]
disabled = false
format = '🕙[\[$time\]]($style) '
time_format = '%T'
utc_time_offset = '+7'

[git_branch]
symbol = '🌱 '
truncation_length = 70
truncation_symbol = '...'
format = 'on [$symbol$branch(:$remote_branch)]($style) '

[package]
disabled = true

[gcloud]
disabled = true

[openstack]
disabled = true

[container]
disabled = true

[docker_context]
disabled = true
EOF
  info "Starship config created."
fi

# ── Fish config check ────────────────────────────────────────
FISH_CONFIG="$HOME/.config/fish/config.fish"
if [ -f "$FISH_CONFIG" ]; then
  # Starship
  if grep -q "starship init fish" "$FISH_CONFIG"; then
    info "Starship init already in config.fish"
  else
    warn "Adding starship init to config.fish"
    echo -e '\nstarship init fish | source' >> "$FISH_CONFIG"
  fi

  # STARSHIP_CONFIG env
  if grep -q "STARSHIP_CONFIG" "$FISH_CONFIG"; then
    info "STARSHIP_CONFIG already set in config.fish"
  else
    warn "Adding STARSHIP_CONFIG to config.fish"
    sed -i '' '1s/^/set -Ux STARSHIP_CONFIG ~\/.config\/fish\/starship.toml\n/' "$FISH_CONFIG"
  fi

  # Carapace
  if grep -q "carapace" "$FISH_CONFIG"; then
    info "Carapace already in config.fish"
  else
    warn "Adding Carapace init to config.fish"
    cat >> "$FISH_CONFIG" <<'EOF'

# Carapace for autocompletion
set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
carapace _carapace | source
EOF
  fi
else
  warn "config.fish not found at $FISH_CONFIG — skipping fish config patch"
fi

# ── Done ─────────────────────────────────────────────────────
echo ""
echo "============================================"
info "Setup complete!"
echo "  Starship : $(starship --version | head -1)"
echo "  Carapace : $(carapace --version)"
echo ""
echo "  Reload fish shell to apply changes:"
echo "    source ~/.config/fish/config.fish"
echo "============================================"
