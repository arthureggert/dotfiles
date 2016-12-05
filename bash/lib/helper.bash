function _load_bash_files() {
  subdirectory="$1"
  if [ -d "${subdirectory}" ]
  then
    FILES="${subdirectory}*.bash"
    for config_file in $FILES
    do
      if [ -e "${config_file}" ]; then
        source $config_file
        #echo $config_file
      fi
    done
  fi
}
