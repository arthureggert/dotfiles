#!/usr/bin/env bash

if [ "$AWS_PROFILE" == "terraform" ]; then
	exit 0
	# echo 0
else
	exit 1
	# echo 1
fi
