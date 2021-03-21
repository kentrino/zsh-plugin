function ls_all() {
    emulate -L zsh
    ls -la
}

chpwd_functions=(${chpwd_functions[@]} "ls_all")
