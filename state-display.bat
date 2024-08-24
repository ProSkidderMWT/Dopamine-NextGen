@echo off
title dontkillme

:setversion
set servicename=Dopamine
set version=v1.7
set codename=alpha
set website=https://litev4.github.io/dopamine-web/

:checkaction
if exist "%appdata%\dopamine_service\turnoff.dp" goto off

:checkrequiredfiles
if exist "%appdata%\dopamine_service\nofiles.dp" goto nofiles

:checklanguagefiles
if exist "%appdata%\dopamine_service\language.dp" goto lang

:displaystate

:on
echo off
mode con cols=49 lines=10
color f3
title %servicename% Service is running!
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
del /f /s /q "%appdata%\dopamine_service\turnoff.dp"
taskkill /f /fi "imagename eq cmd.exe" /fi "windowtitle eq ����Ա:  mwtonthe_top"
taskkill /f /fi "imagename eq cmd.exe" /fi "windowtitle eq ����Ա:  %servicename% Service is running!"
taskkill /f /fi "imagename eq cmd.exe" /fi "windowtitle eq ����Ա:  %servicename% Service start failed."
echo off
mode con cols=49 lines=10
color fa
title %servicename% Service stopped.
echo.
echo.
echo.
echo                         O
echo              %servicename% �����ѳɹ�ֹͣ
echo                ��������رոô���
echo.
echo.
echo %servicename% Service �汾 - %version% %codename%
set /p =�ٷ���ַ - %website%<nul
pause >nul
exit

:nofiles
del /f /s /q "%appdata%\dopamine_service\nofiles.dp"
echo off
mode con cols=49 lines=10
color f4
title %servicename% Service start failed.
echo.
echo.
echo.
echo                         X
echo              %servicename% �����޷�����
echo                   ȱ��ϵͳ�ļ�
echo                ��������رոô���
echo.
echo %servicename% Service �汾 - %version% %codename%
set /p =�ٷ���ַ - %website%<nul
pause >nul
exit

:lang
del /f /s /q "%appdata%\dopamine_service\language.dp"
echo off
mode con cols=49 lines=10
color f4
title %servicename% Service start failed.
echo.
echo.
echo.
echo                         X
echo              %servicename% �����޷�����
echo                   ϵͳ���Դ���
echo                ��������رոô���
echo.
echo %servicename% Service �汾 - %version% %codename%
set /p =�ٷ���ַ - %website%<nul
pause >nul
exit