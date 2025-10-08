# ========= Nushell env.nu =========
use std/util "path add"

# ---------- Homebrew (add if missing) ----------
path add "/opt/homebrew/bin"
path add "/opt/homebrew/sbin"

# ---------- Cargo ----------
path add $"($nu.home-path)/.cargo/bin"

# ---------- Neovim (bob) ----------
path add $"($nu.home-path)/.local/share/bob/nvim-bin"
alias vim = nvim
$env.MANPAGER = "nvim +Man!"

# ---------- pixi ----------
path add $"($nu.home-path)/.pixi/bin"

# ---------- Go ----------
path add "/usr/local/go/bin"

# ---------- fzf ----------
$env.FZF_DEFAULT_OPTS = "--layout=reverse --exact --border=bold --border=rounded --margin=3% --color=dark"

## ---------- starship ----------
## Use a Nushell-specific starship config if you have one:
## $env.STARSHIP_CONFIG = "~/.config/starship/starship-nu.toml"
#if (which starship | is-empty) == false {
#  if not ($"($nu.home-path)/.cache/starship-init.nu" | path exists) {
#    use starship init nu | save --force $"($nu.home-path)/.cache/starship-init.nu"
#  }
#  source $"($nu.home-path)/.cache/starship-init.nu"
#}

# ---------- GPG ----------
# GPG expects a TTY path (use external `tty`)
if (which gpg | is-empty) == false and (which tty | is-empty) == false {
  $env.GPG_TTY = ( ^tty | str trim )
}

# ---------- local ----------
path add $"($nu.home-path)/.local/bin"
path add $"($nu.home-path)/.local/google-cloud-sdk/bin"
path add "/usr/local/bin"

# ---------- nix ----------
path add /nix/var/nix/profiles/default/bin

# ---------- LaTeX ----------
path add "/Library/TeX/texbin"

# ---------- emacs ----------
path add $"($nu.home-path)/.emacs.d/bin"

# ========= end of env.nu =========
