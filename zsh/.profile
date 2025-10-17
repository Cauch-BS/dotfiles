# ~/.profile: executed by the command interpreter for login shells.

# if running bash
if [ -n "$ZSH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
	. "$HOME/.zshrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes a user's shared binaries if they exist
if [ -d "$HOME/.local/share" ] ; then
    PATH="$HOME/.local/share:$PATH"
fi

cd $HOME || exit #fix navigation to windows c mount issue in wsl

. "$HOME/.local/bin/env"
