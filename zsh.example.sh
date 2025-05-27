#.zshrc
# Load dotfiles:
for file in ~/.dotfiles/.{uvrc,aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

source ~/.local/pyenv/.venv/bin/activate
