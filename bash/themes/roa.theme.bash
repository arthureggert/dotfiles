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
SCM_THEME_BRANCH_TRACK_PREFIX=' → '
SCM_THEME_BRANCH_GONE_PREFIX=' ⇢ '
SCM_THEME_CURRENT_USER_PREFFIX=' ☺︎ '
SCM_THEME_CURRENT_USER_SUFFIX=''

THEME_BATTERY_PERCENTAGE_CHECK=true

SCM_GIT='git'
SCM_GIT_DETACHED_CHAR='⌿'
SCM_GIT_AHEAD_CHAR="↑"
SCM_GIT_BEHIND_CHAR="↓"
SCM_GIT_UNTRACKED_CHAR="?:"
SCM_GIT_UNSTAGED_CHAR="U:"
SCM_GIT_STAGED_CHAR="S:"

SCM_NONE='NONE'
SCM_NONE_CHAR=''

SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY="${bold_red}dirty${normal}"
SCM_THEME_PROMPT_CLEAN="${bold_green}clean${normal}"
SCM_GIT_CHAR="�"

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
    if [[ "${THEME_BATTERY_PERCENTAGE_CHECK}" = true ]]; then
        echo -e "${bold_red}$(battery_percentage)%${normal}"
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
        echo -e "${bold_yellow}on $(git_color)$(scm_char)$(git_branch_name) $SCM_THEME_PROMPT_DIRTY${normal}"
      else
        echo -e "${bold_yellow}on $(git_color)$(scm_char)$(git_branch_name) $SCM_THEME_PROMPT_CLEAN${normal}"
      fi

    fi
}

function prompt {
    scm_prompt_info
    my_ps_host="${green}\h${normal}${bold_purple} with ${normal}$(battery_char)${normal}"
    my_ps_user="${bold_green}\u${normal}"
    PS1="${TITLEBAR}$(clock_char)$my_ps_user ${bold_red}at${normal} $my_ps_host ${bold_cyan}in ${cyan}\w${normal} $(modern_scm_prompt)
${bold_orange}-> ${normal}"
}

TITLEBAR=""
PS3=">> "
PS2=">>> "

safe_append_prompt_command prompt
