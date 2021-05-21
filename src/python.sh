if type pyenv > /dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi
export PATH="$HOME/.poetry/bin:$PATH"
