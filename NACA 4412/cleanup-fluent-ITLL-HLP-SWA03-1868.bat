echo off
set LOCALHOST=%COMPUTERNAME%
set KILL_CMD="C:\PROGRA~1\ANSYSI~1\v181\fluent/ntbin/win64/winkill.exe"

"C:\PROGRA~1\ANSYSI~1\v181\fluent\ntbin\win64\tell.exe" ITLL-HLP-SWA03 51671 CLEANUP_EXITING
if /i "%LOCALHOST%"=="ITLL-HLP-SWA03" (%KILL_CMD% 12104) 
if /i "%LOCALHOST%"=="ITLL-HLP-SWA03" (%KILL_CMD% 9796) 
if /i "%LOCALHOST%"=="ITLL-HLP-SWA03" (%KILL_CMD% 11848) 
if /i "%LOCALHOST%"=="ITLL-HLP-SWA03" (%KILL_CMD% 9728) 
if /i "%LOCALHOST%"=="ITLL-HLP-SWA03" (%KILL_CMD% 1868) 
if /i "%LOCALHOST%"=="ITLL-HLP-SWA03" (%KILL_CMD% 3744)
del "\\itll-fs01\student profiles\keco8012\Desktop\CFD Project _ITLL\NACA 4412\cleanup-fluent-ITLL-HLP-SWA03-1868.bat"
