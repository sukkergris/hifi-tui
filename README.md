# hifi-tui

Local music player for the terminal: browse `~/Music` in [fzf](https://github.com/junegunn/fzf) with vim keys and play it with [mpv](https://mpv.io).

## Install (Arch Linux)

```bash
git clone https://github.com/sukkergris/hifi-tui.git ~/Code/hifi-tui
~/Code/hifi-tui/install.sh
```

## Development

`./dev.sh` copies `bin/hifi` (incl. uncommitted changes) to `/usr/bin/hifi`. `./install.sh` puts the packaged version back.
