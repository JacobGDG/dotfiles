#!/bin/bash

# Purpose: quickly edit dotfiles in a tmux popup with chezmoi

# if $1 == start then start tmux session in popup and call this script again withou $1

if [ "$1" == "start" ]; then
  tmux display-popup -E "~/.scripts/dotedit.sh"
  exit 0
fi

echo "Looking for changes upstream..."

chezmoi git -- fetch

if [[ $(chezmoi git -- status) == *"Your branch is behind"* ]]; then
  clear

  echo "Changes upstream. You should pull and apply them first. Run:"
  echo ""
  echo "chezmoi git -- pull"
  echo "chezmoi apply -v"
  echo ""
  echo "Press any key to continue... "

  read -n 1 -r

  exit 1
fi

echo "All clear. Continuing..."
sleep 1

clear

chezmoi edit

# check for any changes in chezmoi
if [[ $(chezmoi diff) != "" ]]; then
  read -p "Apply changes? (y/n) " -n 1 -r

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    clear

    echo "Applying changes..."

    chezmoi apply -v

    # wait for user to read output
    read -p "Press any key to continue... " -n 1 -r
  fi
else
  echo "Nothing to apply. Continuing..."
  sleep 1
fi

clear

# check for any changes and exit if none
if [[ $(chezmoi git -- status) == *"nothing to commit, working tree clean"* ]]; then
  echo "No changes to commit."
  echo "Exiting..."
  sleep 1
  exit 0
fi

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
