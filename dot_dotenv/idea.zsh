function datagrip() {
	declare -a intellij_args=()
	declare -- wait=""

	for o in "$@"; do
		if [[ "$o" = "--wait" || "$o" = "-w" ]]; then
			wait="-W"
			o="--wait"
		fi
		if [[ "$o" =~ " " ]]; then
			intellij_args+=("\"$o\"")
		else
			intellij_args+=("$o")
		fi
	done

	open -na "/Users/arthur.eggert/Applications/DataGrip.app/Contents/MacOS/datagrip" $wait --args "${intellij_args[@]}"
}

function studio() {
  declare -a intellij_args=()
  declare -- wait=""

  for o in "$@"; do
    if [[ "$o" = "--wait" || "$o" = "-w" ]]; then
      wait="-W"
      o="--wait"
    fi
    if [[ "$o" =~ " " ]]; then
      intellij_args+=("\"$o\"")
    else
      intellij_args+=("$o")
    fi
  done

  open -na "/Users/arthur.eggert/Applications/Android Studio.app/Contents/MacOS/studio" $wait --args "${intellij_args[@]}"
}

function idea() {
  declare -a intellij_args=()
  declare -- wait=""

  for o in "$@"; do
    if [[ "$o" = "--wait" || "$o" = "-w" ]]; then
      wait="-W"
      o="--wait"
    fi
    if [[ "$o" =~ " " ]]; then
      intellij_args+=("\"$o\"")
    else
      intellij_args+=("$o")
    fi
  done

  open -na "/Users/arthur.eggert/Applications/IntelliJ IDEA Ultimate.app/Contents/MacOS/idea" $wait --args "${intellij_args[@]}"
}