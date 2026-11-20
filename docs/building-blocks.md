# The 4 building blocks

hifi is built like bluos and ytcast: **fzf is the UI, another program makes the sound, and the script calls itself from fzf's key bindings.** Here the sound is mpv, controlled over its JSON IPC socket.

## 1. Talk to mpv

Start mpv without a window, listening on a socket. Send one JSON line, get one back:

```bash
mpv --idle --no-video --no-terminal --input-ipc-server="$sock" &
mpv_cmd() { jq -cn '{command: $ARGS.positional}' --args "$@" | socat - "$sock"; }
prop()    { mpv_cmd get_property "$1" | jq -r '.data // empty'; }
```

`mpv_cmd cycle pause` sends `{"command":["cycle","pause"]}`. Every command from mpv's `input.conf` works this way, e.g. `playlist-next`, `add volume 5`, `seek 10`.

## 2. The list

Just `find` piped into fzf:

```bash
find . -type f | sed 's|^\./||' | audio | fzf ...
```

`audio` keeps the audio files and skips covers etc.: `grep -iE '\.(flac|mp3|m4a|ogg|opus|wav)$' | sort`.

## 3. Calling itself

Each key runs `$self _something`, and a `case` at the top of the script picks it up (same pattern as `_enter`, `_key` and `_ticker` in bluos):

```bash
--bind "enter:execute-silent($self _play {})"
--bind "space:execute-silent($self _cmd cycle pause)"
```

`_play` writes the chosen track and the rest of its folder to an `.m3u` and runs `loadlist ... replace`, so the album keeps playing from there.

## 4. "Now playing" in the footer

A background loop asks mpv every second and pushes the result into fzf through its `--listen` socket (like bluos):

```bash
curl -s --unix-socket "$dir/fzf.sock" -XPOST http://localhost -d "change-footer:$np"
```

## Next steps

1. **Seek** with `h`/`l` via `_cmd seek -10` / `_cmd seek 10`.
2. **Highlight the playing track** in the list (like `tracks()` in bluos: `reload` from the ticker when the title changes).
3. **Albums instead of tracks**: `find -type d`, then `l`/`h` in and out, like the tab switching in bluos.
