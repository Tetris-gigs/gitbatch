@echo off
SETLOCAL

REM Check if Python 3.11.4 is installed
python --version | findstr "3.11.4" >nul
if %ERRORLEVEL% neq 0 (
    echo Python 3.11.4 not found, downloading and installing...
    REM Download Python 3.11.4 installer
    curl -O https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe
    
    REM Install Python silently with pip and setting it to PATH
    python-3.11.4-amd64.exe /quiet InstallAllUsers=1 PrependPath=1
    
    REM Check if Python installation was successful
    python --version | findstr "3.11.4" >nul
    if %ERRORLEVEL% neq 0 (
        echo Python installation failed.
        exit /b 1
    )
    echo Python 3.11.4 installed successfully.
) else (
    echo Python 3.11.4 is already installed.
)

REM Change directory to where the gitbatch repository is located
cd /d %~dp0

REM Run the Go command to get the repository
go get github.com/Tetris-gigs/gitbatch/cmd/gitbatch

REM Run the Python script (updating_python.py located in internal/app folder)
python internal/app/updating_python.py

echo Script execution completed.
ENDLOCAL
