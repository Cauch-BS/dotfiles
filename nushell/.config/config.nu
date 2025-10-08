$env.config.buffer_editor = 'nvim'
alias nu-open = open
alias open = ^open
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
