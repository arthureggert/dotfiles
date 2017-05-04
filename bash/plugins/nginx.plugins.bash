function nginx () {
	if [[ $1 == 'start' ]]; then
		echo 'starting nginx'
		start c/Program\ Files/nginx/1.13.0/nginx.exe > /dev/null
		echo 'done'
	elif [[ $1 == 'stop' ]]; then 
		echo 'stoppping nginx'
		/c/Program\ Files/nginx/1.13.0/nginx.exe -s stop 
		echo 'done'
	else
		echo 'Provide a operation to be done'
	fi
}
