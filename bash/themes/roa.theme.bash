CLOCK_CHAR_THEME_PROMPT_PREFIX=''
CLOCK_CHAR_THEME_PROMPT_SUFFIX=''
CLOCK_THEME_PROMPT_PREFIX=''
CLOCK_THEME_PROMPT_SUFFIX=''
CLOCK_CHAR=''

THEME_CLOCK_CHECK=true
THEME_PROMPT_HOST='\H'

SCM_CHECK=true

SCM_THEME_BRANCH_PREFIX=''
SCM_THEME_TAG_PREFIX='tag:'
SCM_THEME_DETACHED_PREFIX='detached:'
SCM_THEME_BRANCH_TRACK_PREFIX=''
SCM_THEME_BRANCH_GONE_PREFIX=''   
SCM_THEME_CURRENT_USER_PREFFIX=''
SCM_THEME_CURRENT_USER_SUFFIX=''

THEME_BATTERY_PERCENTAGE_CHECK=true

SCM_GIT='±'
SCM_GIT_DETACHED_CHAR=''
SCM_GIT_AHEAD_CHAR='↑'
SCM_GIT_BEHIND_CHAR='↓'
SCM_GIT_UNTRACKED_CHAR="?:"
SCM_GIT_UNSTAGED_CHAR="U:"
SCM_GIT_STAGED_CHAR="S:"

SCM_NONE='NONE'
SCM_NONE_CHAR=''

SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY="${bold_red}✘${normal}"
SCM_THEME_PROMPT_CLEAN="${bold_green}✓${normal}"
SCM_GIT_CHAR="±"

function scm {
  if [[ "$SCM_CHECK" = false ]]; then SCM=$SCM_NONE
  elif [[ -f .git/HEAD ]]; then SCM=$SCM_GIT
  elif which git &> /dev/null && [[ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]]; then SCM=$SCM_GIT
  else SCM=$SCM_NONE
  fi
}

function scm_prompt_char {
  if [[ -z $SCM ]]; then scm; fi
  if [[ $SCM == $SCM_GIT ]]; then SCM_CHAR=$SCM_GIT_CHAR
  else SCM_CHAR=$SCM_NONE_CHAR
  fi
}

function scm_prompt_info {
  scm
  scm_prompt_char
  SCM_DIRTY=0
  SCM_STATE=''
  [[ $SCM == $SCM_GIT ]] && return
}

function scm_char {
  scm_prompt_char
  echo -e "$SCM_CHAR"
}

function clock_char {
    if [[ "${THEME_CLOCK_CHECK}" = true ]]; then
        #%Y/%m/%d
        DATE_STRING=$(date +"%H:%M:%S")
        echo -e "${bold_cyan}[$DATE_STRING] ${red}$CLOCK_CHAR"
    fi
}

function battery_char {
  if [[ "$HOSTNAME" == 'deathstar' ]]; then
    if [[ "${THEME_BATTERY_PERCENTAGE_CHECK}" = true ]]; then
        echo -e "${bold_red}$(battery_percentage)%${normal}"
    fi
  else 
    echo -e "${bold_red}100%${normal}"
  fi
    
}

function safe_append_prompt_command {
    if [[ -n $1 ]] ; then
        case $PROMPT_COMMAND in
            *$1*) ;;
            "") PROMPT_COMMAND="$1";;
            *) PROMPT_COMMAND="$1;$PROMPT_COMMAND";;
        esac
    fi
}

function modern_scm_prompt {
    if [[ $SCM_CHAR = $SCM_NONE_CHAR ]]; then
        return
    else
      if [ $(git_color) = $red -o $(git_color) = $yellow ] ; then
        echo -e "${bold_yellow}on $(git_color)$(scm_char)$(git_branch_name)${normal} $SCM_THEME_PROMPT_DIRTY${normal}"
      else
        echo -e "${bold_yellow}on $(git_color)$(scm_char)$(git_branch_name)${normal} $SCM_THEME_PROMPT_CLEAN${normal}"
      fi

    fi
}

function get_space {
  local SPACES=' '
  local SPACE=' '
  local LENGTH=59
  local ACTUAL_PWD=$PWD
  local PWD_LENGTH=0
  local GIT_BRANCH_LENGTH=0
  
  if [ -d "$ACTUAL_PWD/.git" ]
    then
    local NAME=$(git_branch_name)
    ((GIT_BRANCH_LENGTH=${#NAME} + 6))
  fi
  
  if [ $ACTUAL_PWD != $HOME  ] 
    then
      ((PWD_LENGTH=${#ACTUAL_PWD} - 22))
  fi
  
  (( LENGTH = ${COLUMNS} - ${LENGTH} - ${PWD_LENGTH} - ${GIT_BRANCH_LENGTH}))

  for i in $(seq 1 $LENGTH)
    do 
      SPACES="$SPACES "
    done

  echo "${SPACES}"
}

function count_lines {
  echo "$1" | egrep -c "^$2" ; 
}

function all_lines {
  echo "$1" | grep -v "^$" | wc -l ; 
}

function status {
  gitsym=$( git symbolic-ref HEAD 2>/dev/null )

  #If exit status OK, we have a branch
  if [[ $? == 0 ]]; then
    # the current branch is the tail end of the symbolic reference
    branch="${gitsym##refs/heads/}"    # get the basename after "refs/heads/"
  fi

  gitstatus=$( git diff --name-status 2>&1 )

  # if the diff is fatal, exit now
  if [[ $? != 0 ]]; then exit 0; fi

  staged_files=$( git diff --staged --name-status )

  num_changed=$(( $( all_lines "$gitstatus" ) - $( count_lines "$gitstatus" U ) ))
  num_conflicts=$( count_lines "$staged_files" U )
  num_staged=$(( $( all_lines "$staged_files" ) - num_conflicts ))
  num_untracked=$( git ls-files --others --exclude-standard $(git rev-parse --show-cdup) | wc -l )

  num_stashed=0
  if [[ "$__GIT_PROMPT_IGNORE_STASH" != "1" ]]; then
    stash_file="$( git rev-parse --git-dir )/logs/refs/stash"
    if [[ -e "${stash_file}" ]]; then
      while IFS='' read -r wcline || [[ -n "$wcline" ]]; do
        ((num_stashed++))
      done < ${stash_file}
    fi
  fi

  clean=0
  if (( num_changed == 0 && num_staged == 0 && num_untracked == 0 && num_stashed == 0 && num_conflicts == 0 )) ; then
    clean=1
  fi

  remote=
  upstream=

  if [[ -z "$branch" ]]; then
    tag=$( git describe --tags --exact-match 2>/dev/null )
    if [[ -n "$tag" ]]; then
      branch="$tag"
    else
      branch="_PREHASH_$( git rev-parse --short HEAD )"
    fi
  else
    remote_name=$( git config branch.${branch}.remote )

    if [[ -n "$remote_name" ]]; then
      merge_name=$( git config branch.${branch}.merge )
    else
      remote_name='origin'
      merge_name="refs/heads/${branch}"
    fi

    if [[ "$remote_name" == '.' ]]; then
      remote_ref="$merge_name"
    else
      remote_ref="refs/remotes/$remote_name/${merge_name##refs/heads/}"
    fi

    # detect if the local branch have a remote tracking branch
    upstream=$( git rev-parse --abbrev-ref ${branch}@{upstream} 2>&1 )

    if [[ $? == 0 ]]; then
      # get the revision list, and count the leading "<" and ">"
      revgit=$( git rev-list --left-right ${remote_ref}...HEAD 2>/dev/null )
      if [[ $? == 0 ]]; then
        num_revs=$( all_lines "$revgit" )
        num_ahead=$( count_lines "$revgit" "^>" )
        num_behind=$(( num_revs - num_ahead ))
        if (( num_behind > 0 )) ; then
          remote="${remote}_BEHIND_${num_behind}"
        fi
        if (( num_ahead > 0 )) ; then
          remote="${remote}_AHEAD_${num_ahead}"
        fi
      fi
    else
      remote='_NO_REMOTE_TRACKING_'
      unset upstream
    fi
  fi

  if [[ -z "$remote" ]] ; then
    remote='.'
  fi

  if [[ -z "$upstream" ]] ; then
    upstream='^'
  fi

  echo ${SCM_GIT_AHEAD_CHAR}${num_ahead} ${SCM_GIT_BEHIND_CHAR}${num_behind}
}

function prompt {
    scm_prompt_info
    my_ps_host="${green}\h${normal}${bold_purple} with ${normal}$(battery_char)${normal}"
    my_ps_user="${bold_green}\u${normal}"
    PS1="${TITLEBAR}${normal}$(clock_char)$my_ps_user ${bold_red}at${normal} $my_ps_host ${bold_cyan}in ${cyan}\W${normal} $(modern_scm_prompt)${bold_orange}${normal}\n$ ${normal}"
}

TITLEBAR=""
PS3=">> "
PS2=">>> "

safe_append_prompt_command prompt
