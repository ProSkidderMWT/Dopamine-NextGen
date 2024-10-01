@echo off
title dontkillme

:setwindowsize
mode con cols=49 lines=10

:setversion
set servicename=Dopamine
set version=v1.0
set versiontype=release
set website=https://litev4.github.io/dopamine-web/

:settext
set running=%servicename% �����ѳɹ�����
set stopped=%servicename% �����ѳɹ�ֹͣ
set failed=%servicename% �����޷�����
set desc1=%servicename% Service �汾 -
set desc2=�ٷ���ַ -
set desc3=%servicename% Service version -
set desc4=Official website -
set running1= %servicename%�������ں�̨�ɹ����У�
set running2= �����ڿ��԰�ȫ�Ĺرմ˴����ˣ�
set running3= �ٴδ�%servicename%��ִ���ļ�����رշ���
set stopped1= %servicename%����Ĺرղ�����ִ�У�
set stopped2= �����ڿ��԰�ȫ�Ĺرմ˴����ˣ�
set stopped3= �ٴδ�%servicename%��ִ���ļ��������´򿪷���
set failed1= %servicename%����δ��������
set failed2= ��⵽����Windows��װȱ��%servicename%�����ļ���
set failed3= �볢������"sfc /scannow"�����ϵͳ��ȱ�ٵ��ļ���
set yes=��
set no=x
set sad=:(
set correct=O
set lines=-------------------------------------------------
set language= Oops,there's something wrong with %servicename%!
set language1= If you are seeing this text,
set language2= which means %servicename% doesn't support your Windows installation's language.
set language3= Try to switch to %servicename% version v1.3 alpha + patch2,it may help this.

:setfirststate
set action=on

:checkaction
if exist "%appdata%\dopamine_service\turnoff.dp" set action=off

:checkrequiredfiles
if exist "%appdata%\dopamine_service\nofiles.dp" set action=nofiles

:checklanguagefiles
if exist "%appdata%\dopamine_service\language.dp" set action=lang

:actioncheck
if %action%==on goto stateon
if %action%==off goto off
if %action%==nofiles goto nofiles
if %action%==lang goto lang


:displaystate
if %action%==lang mode con cols=76 lines=10
title %statetext%
echo.
echo   %stateicon% %statetext%
echo %lines%
echo.
echo %statetext1%
echo %statetext2%
echo %statetext3%
echo.
echo %desc1% %versiontype% %version%
set /p ="%desc2% %website%"<nul
pause >nul
exit

:off
del /f /s /q "%appdata%\dopamine_service\turnoff.dp"
taskkill /f /fi "imagename eq cmd.exe" /fi "windowtitle eq ����Ա:  mwtonthe_top"
del /f /s /q "%appdata%\dopamine_service\state.dp"
set stateicon=%correct%
set statetext=%stopped%
set statetext1=%stopped1%
set statetext2=%stopped2%
set statetext3=%stopped3%
color f3
goto displaystate

:nofiles
del /f /s /q "%appdata%\dopamine_service\nofiles.dp"
set stateicon=%no%
set statetext=%failed%
set statetext1=%failed1%
set statetext2=%failed2%
set statetext3=%failed3%
color f4
goto displaystate

:lang
del /f /s /q "%appdata%\dopamine_service\language.dp"
set stateicon=%sad%
set statetext=%language%
set statetext1=%language1%
set statetext2=%language2%
set statetext3=%language3%
set desc1=%desc3%
set desc2=%desc4%
set lines=----------------------------------------------------------------------------
color f4
goto displaystate

:stateon
set stateicon=%yes%
set statetext=%running%
set statetext1=%running1%
set statetext2=%running2%
set statetext3=%running3%
color fa
goto displaystate