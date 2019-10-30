@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

SET PRODUCT=

FOR /F "tokens=2 delims='" %%a IN (
  'findstr /rc:" *PRODUCT *=> *" pdfmerge.pl'
  ) DO ( SET "PRODUCT=%%a" )

SET EXE=%PRODUCT%.exe

IF (%1) == (test) GOTO TEST

WHERE /q perlapp
IF ERRORLEVEL 1 (
  ECHO "perlapp not found, install"
  EXIT /B
)

SET YEAR=
SET VERSION=
SET ICON=support\pdf.ico

FOR /F "tokens=4 delims=/ " %%i IN ("%date%") DO SET "YEAR=%%i"
FOR /F "tokens=2 delims=v" %%i IN (
    'findstr /rc:" *VERSION *=> *" pdfmerge.pl') DO (
  SET "tv=%%i"
  SET "VERSION=!tv:~0,3!"
)

IF NOT EXIST "C:\Perl\bin" GOTO BIT64

GOTO START

:BIT64
IF NOT EXIST "C:\Perl64\bin" GOTO ABORT

:START

perlapp --icon %ICON% --norunlib --force --info "Comments=Zip merge PDFs given odd and even set of pages;CompanyName=Aquaron;FileDescription=Aquaron %PRODUCT%;FileVersion=%VERSION%;InternalName=%PRODUCT% %VERSION%;LegalCopyright=%YEAR% Aquaron;OriginalFilename=%EXE%;ProductName=%PRODUCT%;ProductVersion=%VERSION%" --exe %EXE% pdfmerge.pl

ENDLOCAL

EXIT /B

:TEST

IF EXIST %EXE% (
  IF EXIST test (
    CD test
    IF EXIST odd.pdf ( IF EXIST even.pdf (
      ..\%EXE% odd.pdf even.pdf
      ECHO Check test dir for result
      EXIT /B
    ) )
  )
  ECHO Can't run test
) ELSE (
  ECHO Run make to build %EXE%
  ECHO Or get from https://github.com/pham/pdfmerge/releases
)

EXIT /B

:ABORT
ECHO Can't find neither a 32-bit nor 64-bit version of ActivePerl
