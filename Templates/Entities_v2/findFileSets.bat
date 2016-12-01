@Echo Off


@rem ================================================================================
@rem ===
@rem ===   void main(String baseDirectory, String filePatterns)
@rem ===
@rem ===   A subroutine which looks for files which match the specified pattern name
@rem ===   at the specified location and prints a list of matching files to the
@rem ===   console.
@rem ===
@rem ===   A file pattern is provided as a quoted list (e.g. ".pdf .txt .csv").
@rem ===
@rem ===
@rem ===   @param baseDirectory
@rem ===          a base directory which is to be searched
@rem ===   @param filePatterns
@rem ===          a set of file name patterns
@rem ===

call:defineMacros


set "__baseDirectory=%1"
if '%__baseDirectory%'=='' (

	%cprintln% Error^(%0^): No base directory has been specified! >&2
	%return% 2
)
set "__baseDirectory=%__baseDirectory:"=%"

if "%__baseDirectory:~-1%" neq "%BACKSLASH%" (

	set "__baseDirectory=%__baseDirectory%%BACKSLASH%"
)


set "__filePatterns=%2"
if '%__filePatterns%'=='' (

	%cprintln% Error^(%0^): No base directory has been specified! >&2
	%return% 2
)
set "__filePatterns=%__filePatterns:"=%"


for %%i in (%__filePatterns%) do (

	call:findFile "%__baseDirectory%" "*%%i"
)


set __baseDirectory=
set __filePatterns=

%return%


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
@rem ---   void findFile(String baseDirectory, String fileName)
@rem ---
@rem ---   A subroutine which looks for files with the specified name at the
@rem ---   specified location and prints a list of matching files to the console.
@rem ---
@rem ---   
@rem ---   @param baseDirectory
@rem ---          a base directory which is to be searched
@rem ---   @param fileName
@rem ---          a file name
@rem ---

:findFile

	set "___baseDirectory=%1"
	if '%___baseDirectory%'=='' (

		%cprintln% Error^(%0^): No base directory has been specified! >&2
		%return% 2
	)
	set "___baseDirectory=%___baseDirectory:"=%"

	if "%___baseDirectory:~-1%" neq "%BACKSLASH%" (

		set "___baseDirectory=%___baseDirectory%%BACKSLASH%"
	)


	set "___fileName=%2"
	if '%___fileName%'=='' (

		%cprintln% Error^(%0^): No file name has been specified! >&2
		%return% 2
	)
	set "___fileName=%___fileName:"=%"


	for /f "delims=*" %%A in ('dir /A-D /B /S "%___baseDirectory%%___fileName%" 2^>nul ^| sort') do (

		%cprintln% %%A
	)


	set ___baseDirectory=
	set ___fileName=

%return%
