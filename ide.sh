#!/bin/bash

# Nome da sessão (pode ser alterado)
SESSION_NAME="LazyVim"

# Caminho do diretório para todas as janelas
WORK_DIR="/home/hid3ki/Documentos/dev/"

# Iniciar uma nova sessão tmux (sem anexar automaticamente)
tmux new-session -d -s $SESSION_NAME -c $WORK_DIR

# Dividir a janela em duas verticalmente e horizontalmente
tmux split-window -v -c $WORK_DIR
tmux split-window -h -c $WORK_DIR

# Redimensionar a janela
tmux resize-pane -D 30

# Garantir que o cursor está na janela 0 (pane inicial)
tmux select-pane -t 0

# Anexar à sessão tmux
tmux attach-session -t $SESSION_NAME

