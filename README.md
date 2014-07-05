# Awesome wm configuration file

![screenshot](screenshot.png)

## Dependencies

### Shifty

This configuration will need [`shifty`](https://github.com/bioe007/awesome-shifty).
You can get it as a submodule of this repository:

```
git submodule init
git submodule update
```

### Programs

You need to have `mocp` running as a server.

Launching `volumeicon` will display a volume widget.

Lastly `xcompmgr` will prevent a bug of chromium redrawing on other tags.

Add the following to you `~/.xinitrc`:

```
xcompmgr &
mocp -S &
volumeicon &
```
