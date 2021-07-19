export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

export PATH="$HOME/.poetry/bin:$PATH"
