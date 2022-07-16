if hash n >/dev/null 2>/dev/null; then
    export N_PREFIX=$HOME/.n
    export PATH=$N_PREFIX/bin:$PATH
fi
