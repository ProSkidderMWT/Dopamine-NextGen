:setversion
set servicename=Dopamine
set version=v1.0
set codename=alpha
set website=https://litev4.github.io/dopamine-web/

:checkaction
if exist %appdata%\dopamine_service\turnoff.dp goto off

:displaystate
echo off
mode con cols=49 lines=10
color f3
title %servicename% Service.
echo.
echo.
echo.
echo                         ��
echo              %servicename% �����ѳɹ�����
echo                ��������رոô���
echo.
echo.
echo %servicename% Service �汾 - %version% %codename%
set /p =�ٷ���ַ - %website%<nul
pause >nul
exit
:off
del /f /s /q %appdata%\dopamine_service\turnoff.dp 
start %appdata%\dopamine\state-off.vbs
taskkill /f /im cmd.exe
exit

