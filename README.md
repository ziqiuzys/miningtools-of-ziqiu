一、
1.创建并配置服务(绝对路径)
```python
  nssm install officeService "D:\hac\worker_windows10.exe"
```
2.启动服务
```python
  nssm start officeService
```
二、
1.用bat启动，右键`start.bat`以管理员身份运行，等待运行结束即可
三、
1.win10注册表记录，开机自启动
`reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v officeService /t REG_SZ /d "D:\hac\miner_worker_2024_02_01_01_windows10" /f`
