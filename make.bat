@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

WHERE /q perlapp
IF ERRORLEVEL 1 (
    ECHO "perlapp not found, install"
    EXIT /B
)

SET YEAR=
SET VERSION=

FOR /F "tokens=4 delims=/ " %%i IN ("%date%") DO SET "YEAR=%%i"
FOR /F "tokens=2 delims=v" %%i IN ('findstr /rc:" *VERSION *=> *" pdfmerge.pl') DO (
  SET "tv=%%i"
  SET "VERSION=!tv:~0,3!"
)

SET EXE=pdfmerge.exe
SET ICON=pdf.ico

IF NOT EXIST "C:\Perl\bin" GOTO BIT64

GOTO START

:BIT64
IF NOT EXIST "C:\Perl64\bin" GOTO ABORT

:START

perlapp --icon %ICON% --norunlib --force --info "Comments=Zip merge PDFs given odd and even set of pages;CompanyName=Aquaron;FileDescription=Aquaron pdfmerge;FileVersion=%VERSION%;InternalName=pdfmerge %VERSION%;LegalCopyright=%YEAR% Aquaron;OriginalFilename=pdfmerge;ProductName=pdfmerge;ProductVersion=%VERSION%" --exe %EXE% pdfmerge.pl

ENDLOCAL

EXIT /B

:ABORT
ECHO Can't find neither a 32-bit nor 64-bit version of ActivePerl
