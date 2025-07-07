# neo's dotfiles

> Note: These dotfiles are meant for my personal use. It might contain hardcoded home path (e.g. /home/neo) or other stuff that might not make it work for you, at least out of the box.

These dotfiles are managed with [Architect](https://github.com/neoapps-dev/architect).

## Installing

> Note: This will clone a replica of my entire system. including packages. Requires Arch GNU/Linux too.

```sh
architect --clone https://github.com/neoapps-dev/dotfiles
architect --dotfiles-sync
architect --apply-diff
```

## Info

Tools used in these dotfiles:

- [Architect](https://github.com/neoapps-dev/architect), The system manager.
- [Wyvern](https://github.com/neoapps-dev/wyvern), The Wayland compositor.
- [fuzzel](https://codeberg.org/dnkl/fuzzel), The app launcher.
- [kitty](https://sw.kovidgoyal.net/kitty/), The terminal.
- [fish](https://fishshell.com/), The main shell.
- [bash](https://www.gnu.org/software/bash/), The secondary shell.
- [waybar](https://github.com/Alexays/Waybar), The top bar.
- [neovim](https://neovim.io/), The text and code editor.
