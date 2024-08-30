# https://asdf-vm.com/guide/getting-started.html
asdf_source="$(brew --prefix asdf)/libexec/asdf.sh"

if [ -s "$asdf_source" ]; then
    . "$asdf_source"
    # append completions to fpath
    fpath=(${ASDF_DIR}/completions $fpath)
    # initialise completions with ZSH's compinit
    autoload -Uz compinit && compinit
fi
