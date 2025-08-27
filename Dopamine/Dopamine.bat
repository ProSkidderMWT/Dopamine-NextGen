@echo off

:mode
set debug=false
set updateskip=false
set window="true"
set notify="true"

:hide
if %debug%==true goto requirefilescheck
if "%1"=="hide" goto requirefilescheck
start mshta vbscript:createobject("wscript.shell").run("""%~0"" hide",0)(window.close)&&exit

:requirefilescheck
if not exist "%systemdrive%\Windows\System32\PING.EXE" goto requirecheckfilesfailed
if not exist "%systemdrive%\Windows\System32\taskkill.exe" goto requirecheckfilesfailed
where powershell|find "powershell.exe" >nul&&goto checklanguage||goto nopowershell

:checklanguage
ver|find "版本" >nul&&set ver="chinese"||set ver="notchinese"
if %ver%=="notchinese" goto languagecheckfailed

:admincheck
net session >nul 2>&1
if %errorlevel% neq 0 (
    PowerShell -Command "Start-Process '%~dpnx0' -Verb RunAs"
    exit /b
)

:setversion
set branch=nextgen
set build=4
if %debug%==true echo %branch%-%build%

:createpath
mkdir "%appdata%\dopamine_service"
mkdir "%appdata%\dopamine_service\config"
if not exist "%appdata%\dopamine_service\config\config.txt" copy "%appdata%\Dopamine\default-config.txt" "%appdata%\dopamine_service\config\config.txt"

:loadsilentconfig
type "%appdata%\dopamine_service\config\config.txt"|find "silent-mode=1]" >nul&&goto only-notification
type "%appdata%\dopamine_service\config\config.txt"|find "silent-mode=2]" >nul&&goto only-window
type "%appdata%\dopamine_service\config\config.txt"|find "silent-mode=3]" >nul&&goto silent-mode
:loadupdatecheckconfig
type "%appdata%\dopamine_service\config\config.txt"|find "skip-update-check=1]" >nul&&set updateskip=true

:checkupdate
if %updateskip%==true goto statecheck
del /f /s /q "%appdata%\dopamine_service\updatetemp.txt"
curl -l https://proskiddermwt.github.io/dopamine-nextgen-web/update/latest.txt > "%appdata%\dopamine_service\updatetemp.txt"
type "%appdata%\dopamine_service\updatetemp.txt"|find "[release_version=" >nul&&echo server connect ok||goto updatefail
type "%appdata%\dopamine_service\updatetemp.txt"|find "%branch%-%build%]" >nul&&set update="true"||set update="false"
if %update%=="true" goto statecheck
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('是否打开浏览器下载Dopamine更新？', 'Dopamine检测到更新', 'YesNo', [System.Windows.Forms.MessageBoxIcon]::Warning);}" > %TEMP%\out.tmp
set /p OUT=<%TEMP%\out.tmp
if %OUT%==No (goto statecheck)
start "" "https://proskiddermwt.github.io/dopamine-nextgen-web/list.html"
exit

:updatefail
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Dopamine 检查更新失败,是否重试？', 'Dopamine %branch%-%build%', 'YesNo', [System.Windows.Forms.MessageBoxIcon]::Warning);}" > %TEMP%\out.tmp
set /p OUT=<%TEMP%\out.tmp
if %OUT%==No (goto statecheck)
goto checkupdate

:statecheck
set state=off
if exist "%appdata%\dopamine_service\state.dp" del /f /s /q "%appdata%\dopamine_service\state.dp"
ping 127.0.0.1 -n 2 >nul
if exist "%appdata%\dopamine_service\state.dp" set state=on

:settext
if %state%==off set text=已关闭，是否开启？
if %state%==on set text=已开启，是否关闭？
if %window%=="false" goto behaviourcheck

:interface
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Dopamine 服务%text%', 'Dopamine %branch%-%build%', 'YesNo', [System.Windows.Forms.MessageBoxIcon]::Information);}" > %TEMP%\out.tmp
set /p OUT=<%TEMP%\out.tmp
if %OUT%==Yes (goto behaviourcheck)
exit

:behaviourcheck
if %state%==off goto mainservice
if %state%==on goto turnoff

:mainservice
title mwtonthe_top
if %notify%=="true" powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Dopamine 服务已开启', '再次打开主程序将会关闭本服务', [System.Windows.Forms.ToolTipIcon]::None)}"
:loop
if not exist "%appdata%\dopamine_service\state.dp" clip > "%appdata%\dopamine_service\state.dp"
taskkill /f /im SeewoCore.exe
if not exist "%appdata%\dopamine_service\state.dp" clip > "%appdata%\dopamine_service\state.dp"
taskkill /f /im SeewoAbility.exe
if not exist "%appdata%\dopamine_service\state.dp" clip > "%appdata%\dopamine_service\state.dp"
taskkill /f /im EasiAgent.exe
if not exist "%appdata%\dopamine_service\state.dp" clip > "%appdata%\dopamine_service\state.dp"
taskkill /f /im Easiupdate3Protect.exe
if not exist "%appdata%\dopamine_service\state.dp" clip > "%appdata%\dopamine_service\state.dp"
taskkill /f /im Easiupdate3.exe
if not exist "%appdata%\dopamine_service\state.dp" clip > "%appdata%\dopamine_service\state.dp"
taskkill /f /im SeewoServiceAssistant.exe
if not exist "%appdata%\dopamine_service\state.dp" clip > "%appdata%\dopamine_service\state.dp"
taskkill /f /im SeewoHugoLauncher.exe
if not exist "%appdata%\dopamine_service\state.dp" clip > "%appdata%\dopamine_service\state.dp"
taskkill /f /im SeewoFreezeUpdateAssist.exe
if not exist "%appdata%\dopamine_service\state.dp" clip > "%appdata%\dopamine_service\state.dp"
goto loop

:turnoff
taskkill /f /fi "imagename eq cmd.exe" /fi "windowtitle eq 管理员:  mwtonthe_top"
if %notify%=="true" powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Dopamine 服务已关闭', '再次打开主程序将会开启本服务', [System.Windows.Forms.ToolTipIcon]::None)}"
exit

:requirecheckfilesfailed
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Dopamine 服务检测到系统文件缺失，是否使用浏览器打开解决方法？', 'Dopamine 服务启动失败', 'YesNo', [System.Windows.Forms.MessageBoxIcon]::Warning);}" > %TEMP%\out.tmp
set /p OUT=<%TEMP%\out.tmp
if %OUT%==Yes (start "" "https://support.microsoft.com/zh-cn/windows/%E5%9C%A8-windows-%E4%B8%AD%E4%BD%BF%E7%94%A8%E7%B3%BB%E7%BB%9F%E6%96%87%E4%BB%B6%E6%A3%80%E6%9F%A5%E5%99%A8-365e0031-36b1-6031-f804-8fd86e0ef4ca")
exit

:languagecheckfailed
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Error; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Dopamine was unable to start', 'Your Windows language is not supported by Dopamine.', [System.Windows.Forms.ToolTipIcon]::None)}"
exit

:silent-mode
set window="false"
set notify="false"
goto loadupdatecheckconfig

:only-window
set window="true"
set notify="false"
goto loadupdatecheckconfig

:only-notification
set window="false"
set notify="true"
goto loadupdatecheckconfig

:nopowershell
start "" "https://proskiddermwt.github.io/dopamine-nextgen-web/help.html"