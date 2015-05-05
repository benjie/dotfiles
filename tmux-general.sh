#!/bin/sh
cd $(dirname "$0")

SESSION_NAME="General"

if ! tmux has-session -t $SESSION_NAME >/dev/null 2>&1; then
  # Window 1 - General
  tmux new-session -s $SESSION_NAME -n General -d

  # Window 2 - Dotfiles
  DIR=./.dotfiles
  tmux new-window -n Dotfiles -c "$DIR"
  tmux split-window -h -c "$DIR"
  tmux send-keys -t $SESSION_NAME "git status" C-m
fi
