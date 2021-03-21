if [ ! -e "$HOME/.zsh/completion/_docker" ]; then
    mkdir -p "$HOME/.zsh"
    mkdir -p "$HOME/.zsh/completion"
    curl \
    -L "https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker" \
    -o "$HOME/.zsh/completion/_docker"
fi

if [ ! -e "$HOME/.zsh/completion/_docker-compose" ]; then
    mkdir -p "$HOME/.zsh"
    mkdir -p "$HOME/.zsh/completion"
    curl \
    -L "https://raw.githubusercontent.com/docker/compose/1.28.5/contrib/completion/zsh/_docker-compose" \
    -o "$HOME/.zsh/completion/_docker-compose"
fi
