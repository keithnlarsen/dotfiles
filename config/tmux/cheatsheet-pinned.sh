#!/usr/bin/env bash
# Pins the cheatsheet in a tmux pane: renders it, keeps the pane alive, and
# re-renders whenever the pane is resized (SIGWINCH). Used by `dev` for the
# top-right pane above Claude.  Ctrl-C to reclaim the pane as a normal shell.
render() { clear; CHEAT_PIN=1 ~/.config/tmux/cheatsheet.sh; }
trap render WINCH
render
while :; do sleep 86400 & wait $! 2>/dev/null; done
