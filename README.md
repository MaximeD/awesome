# Awesome wm configuration file

**⚠ This is not compatible with awesome >= 3.5 ⚠**.

Take a look at [this file](https://github.com/MaximeD/dot-files/blob/master/rc.lua.max) to use with [awesome-copycats](https://github.com/copycat-killer/awesome-copycats) instead.

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
