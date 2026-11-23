@echo off
title UPES Student Attendance Analysis System (Pure C Terminal Core)
cd /d "C:\Users\HP\Desktop\student-attendance-analyzer" 2>nul || cd /d "%~dp0student-attendance-analyzer" 2>nul || cd /d "%~dp0"
cls

:: If executable not yet built, compile with GCC
if not exist "upes_attendance_analyzer.exe" (
    echo [INFO] Compiling Pure C Terminal Attendance Engine with GCC...
    gcc -Wall -Wextra -std=c99 -I c_terminal c_terminal/main.c c_terminal/analytics.c c_terminal/database.c c_terminal/ui_helpers.c c_terminal/student_portal.c c_terminal/faculty_portal.c -o upes_attendance_analyzer.exe
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Compilation failed. Please ensure GCC is installed.
        pause
        exit /b 1
    )
)

:: Run the Pure C Terminal Application
upes_attendance_analyzer.exe
if %ERRORLEVEL% neq 0 (
    echo.
    echo [INFO] Recompiling fresh binary...
    gcc -Wall -Wextra -std=c99 -I c_terminal c_terminal/main.c c_terminal/analytics.c c_terminal/database.c c_terminal/ui_helpers.c c_terminal/student_portal.c c_terminal/faculty_portal.c -o upes_attendance_analyzer.exe
    upes_attendance_analyzer.exe
)

pause
