#!/bin/bash

SESSION_NAME="LazyVim"
WORK_DIR="SEUDIRETORIO"

tmux new-session -d -s $SESSION_NAME -c $WORK_DIR

tmux split-window -v -c $WORK_DIR
tmux split-window -h -c $WORK_DIR

tmux resize-pane -D 30
tmux select-pane -t 0

tmux attach-session -t $SESSION_NAME

