@echo off
chcp 65001 > nul
rem 获取批处理文件的存放路径
set script_dir=%~dp0

rem 切换到批处理文件的存放路径
cd /d %script_dir%

set current_dir=%cd%
set target_dir=%current_dir%\nssm\win64
set exe_name=worker_windows10.exe
set full_path=%current_dir%\%exe_name%
echo 当前目录的绝对路径是：%current_dir%
cd /d %target_dir%
echo 已切换到目录：%cd%
echo 程序完整路径：%full_path%
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v officeService /t REG_SZ /d %full_path%
nssm install officeService %full_path%
echo officeService服务创建完成
nssm start officeService
echo officeService开始执行....
pause
