#!/bin/bash

# TMUX floating window
# Open a popup from any session and be able to show and hide it at will
# Example workflow is to have nvim open as a window, quickly open this pop to access shell then hide again when done.

if [ -z "$TMUX" ]; then
  echo "Error: Not in tmux"
  exit 1
fi

SESSION_NAME=$(tmux display-message -p '#S')

if [[ $SESSION_NAME == *"-popup" ]]; then
  tmux detach
  exit 0
fi

tmux display-popup -E "tmux new-session -A -s \"$SESSION_NAME-popup\""
