$env.config.buffer_editor = 'nvim'
mkdir ($nu.data-dir | path join "vendor/autoload")

#setup starship 
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# setup carapace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir $"($nu.cache-dir)"

# install carpace
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

# load carapace and zoxide
source $"($nu.cache-dir)/carapace.nu"
source $"($nu.home-path)/.zoxide.nu"
