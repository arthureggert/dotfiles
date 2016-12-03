#ENV
kill_grep() {
	kill -9 $(ps -ax | grep $1 | awk '{print $1}')
}

makepasswd() {
	tr -dc A-Za-z0-9@#$-_?= < /dev/urandom | fold -w ${1:-10}  | head -c ${1:-8} | xargs
}

rm_all(){
	rm -rf ..?* .[!.]* *
}
