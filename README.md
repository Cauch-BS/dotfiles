# Cauch-BS's dotfiles

*Inspired by [HeyItsGilbert](https://github.com/HeyItsGilbert/dotfiles).*

This is a repository for storing dotfiles for replicable configuration across devices. 

To use on a Linux Server, do `stow {directory name}`. For example if you want to replicate the `starship` configuration, you can do the following:

```bash
#in case you don't have stow installed
sudo apt install stow
cd dotfiles # or else the name of this repository
stow starship
```

There is some awkwardness when you attempt to overwrite an existing config. In such a case, I recommend doing the following. 

1. Run stow with the --adopt option.
2. Compare the "adopted" files with the ones that were originally in my repo using git diff.
3. Discard all changes introduced by the "adopted" files with git reset --hard, reverting the entire directory the last committed state.

Meanwhile, on windows, manual copy and paste is recommended. 
