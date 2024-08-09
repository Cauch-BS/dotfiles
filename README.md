# Cauch-BS's dotfiles

*Inspired by* [HeyItsGilbert](https://github.com/HeyItsGilbert/dotfiles). 

This is a repository for storing dotfiles for replicable configuration across devices. 

To use on a Linux Server, do `stow {directory name}`. For example if you want to replicate the `starship` configuration, you can do the following:

```bash
#in case you don't have stow installed
sudo apt install stow
cd dotfiles # or else the name of this repository
stow starship
```

On a Windows machine, manual copy and paste is recommended. 