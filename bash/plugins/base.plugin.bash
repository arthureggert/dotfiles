function down4me (){
    # about 'checks whether a website is down for you, or everybody'
    # param '1: website url'
    # example '$ down4me http://www.google.com'
    # group 'base'
    curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

function myip ()
{
    # about 'displays your ip address, as seen by the Internet'
    # group 'base'
    res=$(curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+')
    echo -e "Your public IP is: ${echo_bold_green} $res ${echo_normal}"
}

function pickfrom ()
{
    # about 'picks random line from file'
    # param '1: filename'
    # example '$ pickfrom /usr/share/dict/words'
    # group 'base'
    local file=$1
    [ -z "$file" ] && reference $FUNCNAME && return
    length=$(cat $file | wc -l)
    n=$(expr $RANDOM \* $length \/ 32768 + 1)
    head -n $n $file | tail -1
}


function pmdown ()
{
    # about 'preview markdown file in a browser'
    # param '1: markdown file'
    # example '$ pmdown README.md'
    # group 'base'
    if command -v markdown &>/dev/null
    then
      markdown $1 | browser
    else
      echo "You don't have a markdown command installed!"
    fi
}

function mkcd ()
{
    # about 'make a directory and cd into it'
    # param 'path to create'
    # example '$ mkcd foo'
    # example '$ mkcd /tmp/img/photos/large'
    # group 'base'
    mkdir -p -- "$*"
    cd -- "$*"
}

function lsgrep ()
{
    # about 'search through directory contents with grep'
    # group 'base'
    ls | grep "$*"
}

function quiet ()
{
    # about 'what *does* this do?'
    # group 'base'
    $* &> /dev/null &
}
