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

# ---------- conda ---------- 
$env.CONDA_NO_PROMPT = true

$env.PATH = ($env.PATH | uniq)


# setup default editor
$env.config.buffer_editor = 'nvim'

# setup carapace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir $"($nu.cache-dir)"

# install carpace
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

# load carapace and zoxide
source $"($nu.cache-dir)/carapace.nu"
source $"($nu.home-path)/.zoxide.nu"

# use script
use ~/.config/nushell/scripts/conda.nu

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
$env.MAMBA_EXE = "/opt/homebrew/bin/mamba"
$env.MAMBA_ROOT_PREFIX = "/Users/bazelcu/.local/share/mamba"
$env.PATH = ($env.PATH | append ([$env.MAMBA_ROOT_PREFIX bin] | path join) | uniq)
$env.PROMPT_COMMAND_BK = $env.PROMPT_COMMAND
def --env "mamba activate"  [name: string] {
    #add condabin when base env
    if $env.MAMBA_SHLVL? == null {
        $env.MAMBA_SHLVL = 0
        $env.PATH = ($env.PATH | prepend $"($env.MAMBA_ROOT_PREFIX)/condabin")
    }
    #ask mamba how to setup the environment and set the environment
    (^($env.MAMBA_EXE) shell activate --shell nu $name
      | str replace --regex '\s+' '' --all
      | split row ";"
      | parse --regex '(.*)=(.+)'
      | transpose --header-row
      | into record
      | load-env
    )
    $env.PATH = $env.PATH | split row (char esep)
    # update prompt
    if ($env.CONDA_PROMPT_MODIFIER? != null) {
      $env.PROMPT_COMMAND = {|| $env.CONDA_PROMPT_MODIFIER + (do $env.PROMPT_COMMAND_BK)}
    }
}
def --env "mamba deactivate"  [] {
    #remove active environment except base env
    def --env "micromamba deactivate"  [] {
        for x in (^$env.MAMBA_EXE shell deactivate --shell nu | lines) {
            if ("hide-env" in $x) {
                hide-env (($x | parse "hide-env {var}").0.var)
            } else if ($x =~ "=") {
                let keyValue = ($x
                    | str replace --regex '\s+' "" --all
                    | parse '{key}={value}'
                )
            if ($keyValue | is-empty) == false {
                let k = $keyValue.0.key
                let v = $keyValue.0.value
                # special-case PATH: convert to list
                if $k == "PATH" {
                    let path_list = ($v | split row ":")
                    load-env { PATH: $path_list }
                } else {
                    load-env { $k: $v }
                    }
                }
            }
        }
    # reset prompt
    $env.PROMPT_COMMAND = $env.PROMPT_COMMAND_BK
    }
}

# <<< mamba initialize <<<

#setup starship 
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
