echo passphrase | gpg --passphrase-fd 0 --batch --no-tty --yes "$@"
