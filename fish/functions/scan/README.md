# ~/.config/fish/functions/scan

## Synopsis

```sh
scan <file|fs|pid|port|ssh|wifi>
```

## Description

`scan` is a frontend to various system-scanning tools I can never remember the
syntax for.

These utilities are only available on macOS.

## Options

- `file FILENAME`:
    Tracks access to `FILENAME`.
- `fs`:
    Display a continuous stream of file system access info.
- `pid ID`:
    Track file system access by process `ID`.
- `port NUMBER`:
    Track access on port `NUMBER`
- `ssh`:
    List all SSH-enabled hosts on the current domain.
- `wifi`:
    List all public SSIDs within range.
