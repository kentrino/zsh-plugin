function list_all() {
    emulate -L zsh
    ls -la
}
chpwd_functions=(${chpwd_functions[@]} "list_all")
