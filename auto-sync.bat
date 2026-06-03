@echo off
setlocal

:: 設定 Quartz 專案的路徑
set QUARTZ_DIR=D:\Database\Obsidian-quartz\quartz
:: 設定檢查與同步的時間間隔（秒），例如 1800 秒 = 30 分鐘
set INTERVAL=1800

cd /d %QUARTZ_DIR%

:loop
echo [%date% %time%] 正在啟動自動同步...

:: 執行同步指令
:: --commit (預設 true), --push (預設 true), --pull (預設 true)
call npx.cmd quartz sync --message "Auto-sync content update"

echo [%date% %time%] 同步完成。將在 %INTERVAL% 秒後再次檢查。
timeout /t %INTERVAL% /nobreak > nul
goto loop
