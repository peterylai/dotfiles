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