# etc (My Dotfiles)
## Using My Dotfiles
For example, if you want to use `zshrc`, run `cp zshrc ~/.zshrc` to create a copy or run `ln -svf "$(pwd)/zshrc" ~/.zshrc` to create a soft link.
## Scripts
Some scripts that I wrote/borrowed from someone.

## Shell
I use `zsh` as my main shell.
### zprofile, profile
`.zprofile` is the file to be run by `zsh` when you log in. And in my configuration, `.zprofile` will load `.profile`.

### zshrc, zshrc.d, shellrc, shellrc.d
`.zshrc` is the main config file for zsh. It has some basic configurations, and then it loads `*.zsh` files in `.zshrc.d`, and at last it loads `.shellrc`. `.shellrc` in turn will load `*.sh` files in `.shellrc.d`.
## X
I use `startx` to start my window manager(i3).
### xinitrc, xprofile, Xresources
`.xinitrc` is the file that runs after I type `startx`. It has some basic configurations and it loads `.xprofile` and `.Xresources`, and more importantly, it `exec`s my window manager.
## vim
### vimrc, vim and neovim
`.vimrc` and `.vim` are `vim` configuration files, which can also be used by `neovim`. I have a script called `make_nvim_cfg` to properly link these two files to the `neovim` directory.
## emacs
### emacs.d
This is my emacs configuration.

## proxychains
I often have a `shadowsocks` client listening at port 2080, and applications using `libc` can use `proxychains` for their internet traffic.

## config
### conky
I borrowed the config from garuda linux. `conky` is a dashboard-like software that displays the overall status of your computer.
### htop
Also a config borrowed from someone else. It makes htop look more compact than default.
### i3, i3blocks
This was [Luke Smith](https://github.com/lukesmithxyz)'s config, and I made some modifications.
### mpv
I added some key bindings for panning and zooming. I also added an HD profile for high-end nvidia cards.
### zathura
My pdf/epub/mobi reader. I added some vim bindings.
