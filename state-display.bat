@echo off

:setversion
set servicename=Dopamine
set version=v1.3
set codename=rewrite-backport
set website=https://litev4.github.io/dopamine-web/

:checkaction
if exist %appdata%\dopamine_service\turnoff.dp goto off

:checkrequiredfiles
if exist %appdata%\dopamine_service\nofiles.dp goto nofiles

:displaystate

:on
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
echo %servicename% Service �汾 / %version% %codename%
set /p =�ٷ���ַ / %website%<nul
pause >nul
exit

:off
del /f /s /q %appdata%\dopamine_service\turnoff.dp
start %appdata%\dopamine\state-off.vbs
taskkill /f /im cmd.exe
exit

:nofiles
del /f /s /q %appdata%\dopamine_service\nofiles.dp
echo off
mode con cols=49 lines=10
color f4
title %servicename% Service.
echo.
echo.
echo.
echo                         X
echo              %servicename% �����޷�����
echo                   ȱ��ϵͳ�ļ�
echo                ��������رոô���
echo.
echo %servicename% Service �汾 / %version% %codename%
set /p =�ٷ���ַ / %website%<nul
pause >nul
exit