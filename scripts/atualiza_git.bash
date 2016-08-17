#!/bin/bash

#

cd $1
for file in *; do
	if [[ -d "$file" && ! -L "$file" && -d "$file"/.git ]]; then 
		echo ${file}
		let branch_name = 
		echo $branch_name
	fi
done
