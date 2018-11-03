rem Skip RunEthMinerCommand section at start
goto PreStart

rem ========== Run EthMiner Command ==========

:RunEthMinerCommand

rem ==================== Your Code Starts Here ====================
rem ==================== Your Code Starts Here ====================
rem ==================== Your Code Starts Here ====================

setx GPU_FORCE_64BIT_PTR 0
setx GPU_MAX_HEAP_SIZE 100
setx GPU_USE_SYNC_OBJECTS 1
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_SINGLE_ALLOC_PERCENT 100
PhoenixMiner.exe -pool eu1.ethermine.org:4444 -pool2 eu1.ethermine.org:4444 -wal 0xcf3cdd09dcfe2d5f9dd5e91bb25d083d5f3a6671.rig4 -pass x -proto 3 -ftimeout 120 -cdm 0 -log 0 -minRigSpeed 102.000 -rmode 2 -coin eth -coin2 eth -timeout 2500 -tstop 80 -tstart 70 -rate 0

rem ==================== Your Code Ends Here ====================
rem ==================== Your Code Ends Here ====================
rem ==================== Your Code Ends Here ====================

exit /b

rem ========== PreStart ==========

:PreStart

rem Don't echo to standard output
@echo off
rem Make script variables local
setlocal
rem Set version info
set V=1.9.4 (Donate ETH:0xcf3cdd09dcfe2d5f9dd5e91bb25d083d5f3a6671)
rem Switch to the batch file's directory
cd /d %~dp0
rem Set codepage
chcp 437 >nul
rem Set title
title PHOENiX WatchDog Version %V% by DiGiTaLPaRa_SiMSEK_2018

rem ========== Start ==========

cls
echo ###############################################################################
echo.
echo   PHOENiXminerWatchDog Version %V%
echo.
echo   AUTHOR: SiMSeK  (DiGiTaLPaRa - TO-GitHub)
echo.
echo ###############################################################################
echo.
echo PHOENiXminerWatchDogDmW
echo 1. Run PHOENiX.
echo 2. Restart PHOENiX up to 5 times.
echo 3. Reboot the system.
echo.
echo Additional:
echo - AutoFix #385 issue of PHOENiX
echo - AutoFix #189 issue of PHOENiX
echo - Log file RunTimes.log
echo - Auto Turn off the Error Dialog
echo.

rem ========== Initializing ==========

:Initializing
rem set loop to zero
set /A loopnum=0
set FileOut=RunTimes.log
echo PHOENiXminerWatch Version %V% >> %FileOut%
reg add "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DontShowUI" /t REG_DWORD /d 1 /f > nul 2>&1

rem ========== Run Program ==========

:runProgram

rem ========== Calc ==========

rem Increment loop by one
set /A loopnum=loopnum+1

rem Calculate Date & Time
:DateTime
rem Check if WMIC is available
WMIC.EXE Alias /? >nul 2>&1 || goto wmicError
rem Use WMIC to retrieve date and time
for /F "skip=1 tokens=1-6" %%G in ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year /Format:table') do (
   if "%%~L"=="" goto wmicDone
      set _yyyy=%%L
      set _mm=00%%J
      set _dd=00%%G
      set _hour=00%%H
      set _minute=00%%I
)
:wmicDone

rem Pad digits with leading zeros
      set _mm=%_mm:~-2%
      set _dd=%_dd:~-2%
      set _hour=%_hour:~-2%
      set _minute=%_minute:~-2%

rem Date/time in ISO 8601 format:
set pISOdate=%_yyyy%-%_mm%-%_dd% %_hour%:%_minute%

goto DateTimeOK

:wmicError
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set pdate=%%c-%%a-%%b)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set ptime=%%a:%%b)
set pISOdate=%pdate% %ptime%

:DateTimeOK

rem ========== Output ==========

rem ========== Screen Output ==========

echo.
echo ===============================================================================
echo %pISOdate%
echo PHOENiXminerWatchDogSMSK has run %loopnum% times.
echo ===============================================================================
echo.

rem ========== File Output ==========

echo %pISOdate% PHOENiXminerWatchDogSMSK has run %loopnum% times.>>%FileOut%

rem ========== Execution Code ==========

call :RunEthMinerCommand

rem Wait 5s
timeout /T 5 /NOBREAK>NUL

rem Check 5 loops
if %loopnum% gtr 4 goto ErrorHandling

rem Loop
goto runProgram

rem ========== Error Handling ==========

:ErrorHandling

rem ========== Error Screen Output ==========

echo.
echo ===============================================================================
echo %pISOdate%
echo PHOENiXminerWatchDogSMSK has run %loopnum% times.
echo System restart required.
echo.
echo.
echo.
echo Rebooting now (%pISOdate%).
echo ###############################################################################
echo.

rem ========== Error File Output ==========

echo %pISOdate% ETHminerWatchDogSMSK has run %loopnum% times.>>%FileOut%
echo System restart required. Rebooting now (%pISOdate%).>>%FileOut%
echo. >>%FileOut%
echo. >>%FileOut%

rem ========== System Reboot ==========

shutdown -r -f -t 0

rem ========== End ==========

endlocal

rem ========== EoF ==========
