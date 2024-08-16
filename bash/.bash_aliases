#>>> cargo initialize >>>
export PATH="$HOME/.cargo/bin:$PATH"
. "$HOME/.cargo/env"

#>>>QOL Improvements >>>
#setup eza
alias ls="eza --color=always --long --git --icons=always\
          --no-filesize --no-time --no-user --no-permissions\
          --sort=extension"
#some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lde='ls --tree --level=2'
#setup starship
eval "$(starship init bash)"
#setup neovim
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
alias vim="nvim"
# Define the `link` function
link() {
    if [ $# -eq 0 ] || [ $# -gt 2 ]; then
        echo "Usage: link <source_file> [target_directory]"
        return 1
    fi

    source_file="$1"
    if [ $# -eq 1 ]; then
        target_dir="."
        echo "Target directory not specified. Using current directory."
    else
        target_dir="$2"
    fi

    target_file="${target_dir}/$(basename "$source_file")"
    
    ln -s "$source_file" "$target_file"
    echo "Created symbolic link: $target_file -> $source_file"
}
#setup fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#setup zoxide
eval "$(zoxide init bash)"
alias cd='z'

# Mamba initialization
if [ -f "$HOME/.local/bin/micromamba" ] && [ -d "$HOME/micromamba" ]; then    
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='$HOME/.local/bin/micromamba';
export MAMBA_ROOT_PREFIX='$HOME/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
else
    echo "Mamba files not found. Skipping mamba initialization."
fi

# Conda initialization
if [ -d "$CONDA_PATH" ] && [ -f "$CONDA_PATH/bin/conda" ]; then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$("$CONDA_PATH/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
            . "$CONDA_PATH/etc/profile.d/conda.sh"
        else
            export PATH="$CONDA_PATH/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
else
    echo "Conda files not found. Skipping conda initialization."
fi

alias mamba='micromamba'
# pixi initialization
export PATH=$HOME/.pixi/bin:$PATH
# go initialization
export PATH=$PATH:/usr/local/go/bin
