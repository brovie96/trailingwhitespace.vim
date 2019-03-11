# trailingwhitespace.vim
A trailing whitespace marking and removal plugin for Vim.

### Purpose
If you're like me and hate having useless trailing whitespace at the end of
your lines, this plugin will highlight it so that you can notice and remove it
as you edit. If you have a lot of trailing whitespace to remove, this plugin
also includes a function that will remove all the trailing whitespace from a
file. The highlighting requires `syntax enable` in your Vim configuration.

### Origin
This started out as a bit of [my own Vim config][my Vim config], but then it finally occurred to
me that I could spin this particular bit of functionality off into its own
plugin so that other people could use it. There's probably a lot of this kind
of plugin out there, but mine is very simple and includes the minimum amount of
functionality necessary to do the two things that it does.

### Installation
Install `brovie96/trailingwhitespace.vim` in your favorite plugin manager (I
personally like [vim-plug][vim-plug]). If you want to use the trailing
whitespace removal function, add a line in your Vim config to `nnoremap` a call
to `trailingwhitespace#ClearTrailingWhitespace()` to your preferred key
sequence (I use `<leader>w`).

[my Vim config]: https://github.com/brovie96/vimrc/
[vim-plug]: https://github.com/junegunn/vim-plug/
