#!/usr/bin/env bash

cd $1
export GRADLE_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
gradle tomcatRun --refresh-dependencies
