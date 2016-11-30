@Echo Off


@rem ================================================================================
@rem ===
@rem ===   void main()
@rem ===
@rem ===   This script creates an index file which can be used with a browser.
@rem ===

call:defineMacros
call:defineConstants


set subroutineCalls.length=3
set subroutineCalls[1]=writeDocumentHead
set subroutineCalls[2]=writeDocumentBody
set subroutineCalls[3]=writeDocumentTail


for /L %%i in (1,1,%subroutineCalls.length%) do (

	call:invokeSubroutine %%i
	%ifError% (

		%return%
	)
)

for /L %%i in (1,1,%subroutineCalls.length%) do (

	set subroutineCalls[%%i]=
)
set subroutineCalls.length=


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

	set DEFAULT_INDEX_FILE=index.html
	set DEFAULT_FILE_PATTERN=*.xml

%return%


@rem --------------------------------------------------------------------------------
@rem ---
@rem ---   void invokeSubroutine(int anIndex, String... someParams)
@rem ---
@rem ---   The subroutine invokes a subroutine which is specified in an array.
@rem ---
@rem ---
@rem ---   @param anIndex
@rem ---          the index of the subroutine
@rem ---   @param someParams
@rem ---          command line parameters that were provided
@rem ---

:invokeSubroutine

	set "_index=%1"
	if '%_index%'=='' (

		%cprintln% Error^(%0^): No index has been specified! >&2
		%return% 2
	)
	set "_index=%_index:"=%"


	setlocal EnableDelayedExpansion

		set _tmpName=!subroutineCalls[%_index%]!

	endlocal & set _subroutineName=%_tmpName%


	%cprintln% execute %_subroutineName% ...

	call:%_subroutineName% %DEFAULT_INDEX_FILE%
	%ifError% (

		%cprintln%.
		%cprintln% ERROR^(%_subroutineName%^): An error occured! >&2
		%return% 2
	)


	set _subroutineName=
	set _index=

%return%


@rem --------------------------------------------------------------------------------
@rem ---
@rem ---   void writeDocumentHead(String fileName)
@rem ---
@rem ---   The subroutine writes a document head to the specified file.
@rem ---
@rem ---
@rem ---   @param fileName
@rem ---          a file name
@rem ---

:writeDocumentHead

	set "_fileName=%1"
	if '%_fileName%'=='' (

		%cprintln% Error^(%0^): No file name has been specified! >&2
		%return% 2
	)
	set "_fileName=%_fileName:"=%"


	(
		echo ^<!DOCTYPE HTML^>
		echo.
		echo ^<html^>
		echo.
		echo 	^<head^>
		echo 		^<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /^>
		echo 		^<title^>Index^</title^>
		echo 	^</head^>
		echo.
		echo 	^<body^>
		echo.
	) > %_fileName%


	set _fileName=

%return%


@rem --------------------------------------------------------------------------------
@rem ---
@rem ---   void writeDocumentBody(String fileName)
@rem ---
@rem ---   The subroutine writes a document body to the specified file.
@rem ---
@rem ---   
@rem ---   @param fileName
@rem ---          a file name
@rem ---

:writeDocumentBody

	set "_fileName=%1"
	if '%_fileName%'=='' (

		%cprintln% Error^(%0^): No file name has been specified! >&2
		%return% 2
	)
	set "_fileName=%_fileName:"=%"


	(
		echo 		^<h1^>Index^</h1^>
		echo.
		echo 		^<ul^>
	) >> %_fileName%

	for /f "delims=*" %%A in ('dir /A-D /B /S "%DEFAULT_FILE_PATTERN%" 2^>nul ^| sort') do (

		call:writeListItem "%_fileName%" "%%A"
	)

	(
		echo 		^</ul^>
	) >> %_fileName%


	set _fileName=

%return%


@rem --------------------------------------------------------------------------------
@rem ---
@rem ---   void writeListItem(String fileName, String listItem)
@rem ---
@rem ---   The subroutine writes adds the specified list item to the specified file.
@rem ---
@rem ---   
@rem ---   @param fileName
@rem ---          a file name
@rem ---   @param listItem
@rem ---          a list item
@rem ---

:writeListItem

	set "__fileName=%1"
	if '%__fileName%'=='' (

		%cprintln% Error^(%0^): No file name has been specified! >&2
		%return% 2
	)
	set "__fileName=%__fileName:"=%"

	set "__listItem=%2"
	if '%__listItem%'=='' (

		%cprintln% Error^(%0^): No list item has been specified! >&2
		%return% 2
	)
	set "__listItem=%__listItem:"=%"


	set "__currentDirectory=%CD%\"

	setlocal EnableDelayedExpansion

		set "__tmp=%__listItem%"
		set "__tmp=!__tmp:%__currentDirectory%=!"

	endlocal & set "__shortFileName=%__tmp%"

	(
		echo 			^<li^>^<a href="%__shortFileName%" target=_blank^>%__shortFileName%^</a^>^</li^>
	) >> %__fileName%


	set __currentDirectory=
	set __shortFileName=
	set __listItem=
	set __fileName=

%return%

@rem --------------------------------------------------------------------------------
@rem ---
@rem ---   void writeDocumentTail(String fileName)
@rem ---
@rem ---   The subroutine writes a document tail to the specified file.
@rem ---
@rem ---
@rem ---   @param fileName
@rem ---          a file name
@rem ---

:writeDocumentTail

	set "_fileName=%1"
	if '%_fileName%'=='' (

		%cprintln% Error^(%0^): No file name has been specified! >&2
		%return% 2
	)
	set "_fileName=%_fileName:"=%"


	(
		echo.
		echo 	^</body^>
		echo.
		echo ^</html^>
	) >> %_fileName%


	set _fileName=

%return%
