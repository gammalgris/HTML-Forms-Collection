@Echo Off


@rem ================================================================================
@rem ===
@rem ===   void main(String targetDirectory)
@rem ===
@rem ===   This script creates an index file which can be used with a browser.
@rem ===
@rem ===
@rem ===   @param targetDirectory
@rem ===          the target directory
@rem ===

call:defineMacros
call:defineConstants


set "targetDirectory=%1"
if '%targetDirectory%'=='' (

	%cprintln% Error^(%0^): No target directory has been specified! >&2
	%return% 2
)
set "targetDirectory=%targetDirectory:"=%"

if "%targetDirectory:~-1%" neq "%BACKSLASH%" (

	set "targetDirectory=%targetDirectory%%BACKSLASH%"
)


set "batchDirectory=%~dp0"


call:cleanDirectory "%targetDirectory%"
%ifError% (

	%return%
)


call:copyFiles "%batchDirectory%" "%targetDirectory%" "%DEFAULT_FILE_PATTERNS%"
%ifError% (

	%return%
)


set batchDirectory=
set targetDirectory=

%return% 0


@rem ================================================================================
@rem ===
@rem ===   Internal Subroutines
@rem ===

@rem --------------------------------------------------------------------------------
@rem ---
@rem ---   void defineMacros()
@rem ---
@rem ---   The subroutine defines required macros.
@rem ---

:defineMacros

	set "ifError=set foundErr=1&(if errorlevel 0 if not errorlevel 1 set foundErr=)&if defined foundErr"
	
	set "cprintln=echo"
	set "cprint=echo|set /p="
	
	set "return=exit /b"

%return%


@rem --------------------------------------------------------------------------------
@rem ---
@rem ---   void defineConstants()
@rem ---
@rem ---   The subroutine defines required constants.
@rem ---

:defineConstants

	set TRUE=TRUE
	set FALSE=FALSE

	set BACKSLASH=\

	set "DEFAULT_FILE_PATTERNS=.html .xml .xsd .xsl .js .svg"

%return%


@rem --------------------------------------------------------------------------------
@rem ---
@rem ---   void copyFiles(String baseDirectory, String targetDirectory, String filePatterns)
@rem ---
@rem ---   All files that match the specified file patterns are copied from the
@rem ---   specified base directory to the specified target directory.
@rem ---
@rem ---
@rem ---   @param baseDirectory
@rem ---          the source directory
@rem ---   @param targetDirectory
@rem ---          the target directory
@rem ---   @param filePatterns
@rem ---          a set of file name patterns
@rem ---

:copyFiles

	set "_baseDirectory=%1"
	if '%_baseDirectory%'=='' (

		%cprintln% Error^(%0^): No base directory has been specified! >&2
		%return% 2
	)
	set "_baseDirectory=%_baseDirectory:"=%"

	if "%_baseDirectory:~-1%" neq "%BACKSLASH%" (

		set "_baseDirectory=%_baseDirectory%%BACKSLASH%"
	)


	set "_targetDirectory=%2"
	if '%_targetDirectory%'=='' (

		%cprintln% Error^(%0^): No target directory has been specified! >&2
		%return% 2
	)
	set "_targetDirectory=%_targetDirectory:"=%"

	if "%_targetDirectory:~-1%" neq "%BACKSLASH%" (

		set "_targetDirectory=%_targetDirectory%%BACKSLASH%"
	)


	set "_filePatterns=%3"
	if '%_filePatterns%'=='' (

		%cprintln% Error^(%0^): No file patterns have been specified! >&2
		%return% 2
	)
	set "_filePatterns=%_filePatterns:"=%"


	for /F "delims=*" %%i in ('call findFileSets.bat "%_baseDirectory%" "%_filePatterns%"') do (

		set "_newFileName=%%i"

		setlocal EnableDelayedExpansion

			set "_newFileName=!_newFileName:%_baseDirectory%=%_targetDirectory%!"
			echo xcopy /E /H /I /Y "%%i" "!_newFileName!*"
			xcopy /E /H /I /Y "%%i" "!_newFileName!*"

		endlocal
	)


	set _newFileName=
	set _baseDirectory=
	set _targetDirectory=
	set _filePatterns=

%return%


@rem --------------------------------------------------------------------------------
@rem ---
@rem ---   void cleanDirectory(String path)
@rem ---
@rem ---   Cleans the specified directory (i.e. deletes it an all its contents and
@rem ---   creates it).
@rem ---
@rem ---
@rem ---   @param path
@rem ---          a directory path
@rem ---

:cleanDirectory

	set "_path=%1"
	if '%_path%'=='' (

		echo No path has been specified! >&2
		%return% 2
	)
	set "_path=%_path:"=%"


	set _internaleError=%FALSE%

	if exist "%_path%" (

		rd /S /Q "%_path%"
		%ifError% (

			echo Unable to delete the directory %_path%! >&2
			set _internaleError=%TRUE%
		)

		call:sleep 1
	)

	md "%_path%"
	%ifError% (

		echo Unable to create the directory %_path%! >&2
		set _internaleError=%TRUE%
	)

	call:sleep 1

	if '%_internaleError%'=='%TRUE%' (

		echo Cleaning the directory %_path% was not successful! >&2
		%return% %UNEXPECTED_ERROR%
	)


	set _internaleError=
	set _path=

%return%


@rem --------------------------------------------------------------------------------
@rem ---
@rem ---   void sleep(int sleepTime)
@rem ---
@rem ---   Pauses the current execution for the specified amount of time.
@rem ---
@rem ---
@rem ---   @param sleepTime
@rem ---          a sleep time (in seconds)
@rem ---

:sleep

	set "_sleepTime=%1"
	if '%_sleepTime%'=='' (

		echo No sleep time has been specified! >&2
		%return% 2
	)
	set "_sleepTime=%_sleepTime:"=%"


	timeout %_sleepTime% >nul 2>&1


	set _sleepTime=

%return%
