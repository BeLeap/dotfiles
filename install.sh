#!/bin/bash
echo "[START]"
echo "[PROCESS] update(apt)"
sudo apt update
echo "[PROCESS] upgrade(apt)"
sudo apt upgrade -y
echo "[CALL] fish install.sh"
~/dotfiles/fish/install.sh
echo "[CALL] tmux install.sh"
~/dotfiles/tmux/install.sh
echo "[CALL] vim install.sh"
~/dotfiles/vim/install.sh
echo "[END]"