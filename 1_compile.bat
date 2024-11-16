@echo off

echo.
echo ===========================================================================
echo Compiling
echo ===========================================================================
php -f ../scripts/preprocess.php bmain.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -m ..\scripts\sysmac.sml -l _bmain.lst _bmain.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _bmain.lst ./release/spcp.sav sav
if %ERRORLEVEL% NEQ 0 ( exit /b )

..\scripts\rt11dsk.exe d spcpla.dsk spcp.sav >NUL
..\scripts\rt11dsk.exe a spcpla.dsk .\release\spcp.sav >NUL

..\scripts\rt11dsk.exe d ..\..\03_dsk\hdd.dsk spcp.sav >NUL
..\scripts\rt11dsk.exe a ..\..\03_dsk\hdd.dsk .\release\spcp.sav >NUL

del _bmain.mac
del _bmain.lst
del printer.log

echo.