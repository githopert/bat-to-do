:: A primitive TO-DO list system.
:: author: fat_fox
::
@echo off
chcp 65001 > nul
setlocal EnableDelayedExpansion


:: User settings ----------------------------------------------------------- ::
set editor=nvim
set folder_path=C:\Games\Scripts\todoarchive
:: ------------------------------------------------------------------------- ::


:: Parse the input arguments ----------------------------------------------- ::
if [%1]==[] (

    set arg1=show
    set arg2=

) else (

    set arg1=/i %1
    set arg2=%2

)


:: Main program ------------------------------------------------------------ ::
set curr_date=%date:.=-%
set curr_file=%folder_path%\%curr_date%.txt

call :find_yesterday_date yesterday_date
set yesterday_file=%folder_path%\%yesterday_date%.txt

:: Create a new folder
if not exist %folder_path% (

    echo Creating a folder: %folder_path%...
    mkdir %folder_path%

)

:: Create a new entry
if not exist %curr_file% (

    echo Creating a file: %curr_file%...
    (echo %curr_date% & echo. & echo.) > %curr_file%

    if exist %yesterday_file% (

        call :transfer_undone_tasks %yesterday_file% %curr_file%

    ) else (

        echo [ ] >> %curr_file%

    )

)

:: Show an entry
if %arg1%==show (

    if [%arg2%]==[] (

        call :print_file %curr_file%

    ) else (

        if exist %folder_path%\%arg2%.txt (

            call :print_file %folder_path%\%arg2%.txt

        ) else (

            echo Could not find the file: %arg2%.txt

        )

    )

)

:: Edit an entry
if %arg1%==edit (

    if [%arg2%]==[] (

        %editor% %curr_file%

    ) else (

        if exist %folder_path%\%arg2%.txt (

            %editor% %folder_path%\%arg2%.txt

        ) else (

            echo Could not find the file: %arg2%.txt

        )

    )

)

if %arg1% neq edit if %arg1% neq show (

    echo Use SHOW or EDIT as the first argument!

)

exit /b %ERRORLEVEL%


:: Function definitions ---------------------------------------------------- ::
:print_file

    (echo. & echo.)
    type %~1
    (echo. & echo.)

exit /b 0


:find_yesterday_date

    for /f "delims=" %%a in ('powershell -Command [DateTime]::Today.AddDays^(-1^).ToString^(\"dd-MM-yyyy\"^)') do (

        set %~1=%%a

    )

exit /b 0


:transfer_undone_tasks

    set multiple_lines=false

    for /f "tokens=*" %%i in (%~1) do (

        echo %%i | findstr /l /c:"[ ]" /c:"[/]" /c:"[\]" > nul

        if !ERRORLEVEL!==0 (

            :: Disable this feature to print exclamation points
            setlocal DisableDelayedExpansion
            @echo off
            echo %%i >> %~2
            endlocal

            set multiple_lines=true

        ) else (

            echo %%i | findstr "[x]" > nul

            if !ERRORLEVEL!==0 (

                set multiple_lines=false

            )

            if !multiple_lines!==true (

                setlocal DisableDelayedExpansion
                @echo off
                echo     %%i >> %~2
                endlocal

            )

        )

    )

exit /b 0
