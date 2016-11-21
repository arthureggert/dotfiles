@ECHO OFF
:: Setando variavel
SET RegPath=C:\Users\aheggert\Pictures\fundo.jpg

:: Buscando informação no registro
FOR /F "tokens=3 delims= " %%A IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v Wallpaper') DO SET Wallpaper=%%A
::ECHO Wallpaper=%Wallpaper% 

:: Condições para correção
IF /I %Wallpaper%  EQU %RegPath% GOTO correto
IF /I %Wallpaper%  NEQ %RegPath% GOTO errado
GOTO end

:errado
ECHO !! Foi encontrado uma falha no seu Registro !! 
ECHO !! este sera corrigido agora em alguns passos !!

:: Sleep ou Timeout. Colocado dessa forma devido a falhas nos sistemas operacionais que não tem as duas funções
@ping 127.0.0.1 -n 2 -w 100000000 > nul

cls
ECHO Passo 1...
@ping 127.0.0.1 -n 2 -w 100000000 > nul
:: Deleta informação invalida para o papel de parede
REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v Wallpaper /f

cls
ECHO Passo 2...
@ping 127.0.0.1 -n 2 -w 100000000 > nul
:: Crescenta informação correta no registro
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v Wallpaper /t REG_SZ /d C:\Users\aheggert\Pictures\fundo.jpg /f

GOTO end
  
:correto
GOTO end

:end
:: Limpando variaveis
SET RegPath=
SET Wallpaper=

:: Elimina reg rodando
tskill reg

:: Adiciona excessao av
