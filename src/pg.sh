pg_path="$(brew --prefix libpq)/bin"
if [ -d "$pg_path" ]; then
    export PATH="$pg_path:$PATH"
fi
