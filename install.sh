# create symlinks for configs (will overwrite old configs)

#pyenv
mkdir -p "${HOME}/.local/pyenv"
ln -sf ${HOME}/.dotfiles/pyenv/pyproject.toml "${HOME}/.local/pyenv/pyproject.toml"
ln -sf ${HOME}/.dotfiles/pyenv/uv.lock "${HOME}/.local/pyenv/uv.lock"
cd "${HOME}/.local/pyenv"
uv sync

# zsh-themes
ln -sf ~/.dotfiles/kjgong.zsh-theme ~/.oh-my-zsh/custom/themes/kjgong.zsh-theme


