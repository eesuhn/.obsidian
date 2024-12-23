@echo off
setlocal EnableDelayedExpansion

:: Set title for the window
title Quick Git Commit Tool

:: Check if git is installed
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
	echo Git is not installed or not in PATH
	pause
	exit /b 1
)

:: Check if current directory is a git repository
if not exist ".git" (
	echo Current directory is not a git repository
	pause
	exit /b 1
)

:: Get commit message from argument or prompt if not provided
if "%~1"=="" (
	set /p "commit_msg=Enter commit message: "
) else (
	set "commit_msg=%~1"
)

:: Show current status
echo.
echo Current git status:
git status
echo.

:: Confirm with user
set /p "confirm=Proceed with commit? [Y/N]: "
if /i "!confirm!" NEQ "Y" (
	echo Operation cancelled
	pause
	exit /b 0
)

:: Execute git commands
echo.
echo Staging changes...
git add .
if errorlevel 1 (
	echo Error: Failed to stage changes
	pause
	exit /b 1
)

echo.
echo Committing changes...
git commit -m "!commit_msg!"
if errorlevel 1 (
	echo Error: Failed to commit changes
	pause
	exit /b 1
)

echo.
echo Pushing changes...
git push
if errorlevel 1 (
	echo Error: Failed to push changes
	pause
	exit /b 1
)

echo.
echo Successfully staged, committed, and pushed changes!
pause
exit /b 0
