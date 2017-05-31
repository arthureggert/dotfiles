REM BASH
mklink %HOMEPATH%\.bashrc %HOMEPATH%\Documents\Workspace\dotfiles\bash\bashrc
mklink %HOMEPATH%\.bash_profile %HOMEPATH%\Documents\Workspace\dotfiles\bash\bash_profile

REM GIT
mklink %HOMEPATH%\.gitignore %HOMEPATH%\Documents\Workspace\dotfiles\git\gitignore

REM VIM
mklink %HOMEPATH%\.vimrc %HOMEPATH%\Documents\Workspace\dotfiles\vim\vimrc
mklink /D %HOMEPATH%\.vim %HOMEPATH%\Documents\Workspace\dotfiles\vim\vim

REM BABUN BASH
mklink %HOMEPATH%\.babun\cygwin\home\arthur.eggert\.bashrc %HOMEPATH%\Documents\Workspace\dotfiles\bash\bashrc
mklink %HOMEPATH%\.babun\cygwin\home\arthur.eggert\.bash_profile %HOMEPATH%\Documents\Workspace\dotfiles\bash\bash_profile

REM BABUN GIT
mklink %HOMEPATH%\.babun\cygwin\home\arthur.eggert\.gitignore %HOMEPATH%\Documents\Workspace\dotfiles\git\gitignore

REM BABUN VIM
mklink %HOMEPATH%\.babun\cygwin\home\arthur.eggert\.vimrc %HOMEPATH%\Documents\Workspace\dotfiles\vim\vimrc
mklink /D %HOMEPATH%\.babun\cygwin\home\arthur.eggert\.vim %HOMEPATH%\Documents\Workspace\dotfiles\vim\vim

REM BABUN ZSH
mklink /D %HOMEPATH%\.babun\cygwin\home\arthur.eggert\.oh-my-zsh %HOMEPATH%\Documents\Workspace\dotfiles\zsh\oh-my-zsh
mklink %HOMEPATH%\.babun\cygwin\home\arthur.eggert\.zshrc %HOMEPATH%\Documents\Workspace\dotfiles\zsh\zshrc