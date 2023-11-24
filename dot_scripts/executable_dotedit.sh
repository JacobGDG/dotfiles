#!/bin/bash

# Purpose: quickly edit dotfiles in a tmux popup with chezmoi

# if $1 == start then start tmux session in popup and call this script again withou $1

if [ "$1" == "start" ]; then
  tmux display-popup -E "~/.scripts/dotedit.sh"
  exit 0
fi

chezmoi edit

# ask if you would like to apply changes
read -p "Apply changes? (y/n) " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
  clear

  echo "Applying changes..."

  chezmoi apply -v

  # wait for user to read output
  read -p "Press any key to continue... " -n 1 -r
fi

clear

chezmoi git -- status

read -p "Push changes? (y/n) " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
  clear

  echo "Pushing changes..."

  chezmoi git -- cma
  chezmoi git -- push
fi

clear

echo "Exiting..."
sleep 1

exit 0


