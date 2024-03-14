#!/usr/bin/env bash

account=$(aws sts get-caller-identity --query Account --output text)

if [ "$account" == "$AWS_DEV_ACCOUNT" ]; then
	echo "󰵮"
elif [ "$account" == "$AWS_LIVE_ACCOUNT" ]; then
	echo "󱓇"
else
	echo ""
fi
