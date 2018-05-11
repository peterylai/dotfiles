#Usage

Clone the repo into your home directory:

```bash
cd ~
git clone https://github.com/peterylai/dotfiles.git
```

Then execute the symlink script from the new dotfiles directory:

```bash
cd ~/dotfiles
chmod +x make.sh
./make.sh
```

Edit the content of `.user_gitconfig` in the dotfiles directory:

```bash
# EXAMPLE .user_gitconfig
[user]
  name = "Your Name"
  email = user@email.com
```


## vimrc

1. Delete or move your current .vimrc
1. Create a symlink in your home directory `ln -s ~/link/to/vimrc .vimrc`
1. Open the .vimrc with vim and run `:PluginInstall` to install all the plugins. You may also need to clear previously installed plugins with `:PluginClean`
1. There are two color schemes included. Solarized seems to work out of the box while One requires some jiggering. See the [Vim-One Repo](https://github.com/rakr/vim-one) for info. 
