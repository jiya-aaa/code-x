@echo off
title UPES Student Attendance Analysis System (Port 5000)
cd /d "C:\Users\HP\Desktop\student-attendance-analyzer" 2>nul || cd /d "%~dp0student-attendance-analyzer" 2>nul || cd /d "%~dp0"
cls
echo ======================================================================
echo   UPES Student Attendance Analysis System
echo   Official College Project Prototype - Local Engine Launcher
echo ======================================================================
echo.

:: Free port 5000 if an orphaned background process was left behind
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5000') do (
    taskkill /f /pid %%a >nul 2>&1
)

echo [1/2] Launching UPES Attendance Portal at http://localhost:5000 ...
start "" "http://localhost:5000"

echo [2/2] Starting UPES Server Engine on Port 5000...
echo       ==============================================================
echo       PLEASE KEEP THIS COMMAND WINDOW OPEN WHILE USING THE WEBSITE!
echo       To stop the server, press Ctrl+C or simply close this window.
echo       ==============================================================
echo.

:: 1. Try python command
python server.py 5000
if %ERRORLEVEL% equ 0 goto finish

:: 2. Try py launcher
py -3 server.py 5000
if %ERRORLEVEL% equ 0 goto finish

:: 3. Try virtual environment python
if exist ".venv\Scripts\python.exe" (
    .venv\Scripts\python.exe server.py 5000
    goto finish
)

:: 4. Try C server executable if allowed by policy
if exist "upes_server.exe" (
    upes_server.exe 5000
    goto finish
)

echo.
echo [ERROR] Unable to start the server engine.
echo Please ensure Python is installed and accessible in PATH.
pause

:finish
