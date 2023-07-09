@rem
@rem Copyright 2020 the original author jacky.eastmoon
@rem All commad module need 3 method :
@rem [command]        : Command script
@rem [command]-args   : Command script options setting function
@rem [command]-help   : Command description
@rem Basically, CLI will not use "--options" to execute function, "--help, -h" is an exception.
@rem But, if need exception, it will need to thinking is common or individual, and need to change BREADCRUMB variable in [command]-args function.
@rem NOTE, batch call [command]-args it could call correct one or call [command] and "-args" is parameter.
@rem

@rem ------------------- batch setting -------------------
@rem setting batch file
@rem ref : https://www.tutorialspoint.com/batch_script/batch_script_if_else_statement.htm
@rem ref : https://poychang.github.io/note-batch/

@echo off
setlocal
setlocal enabledelayedexpansion

@rem ------------------- declare CLI file variable -------------------
@rem retrieve project name
@rem Ref : https://www.robvanderwoude.com/ntfor.php
@rem Directory = %~dp0
@rem Object Name With Quotations=%0
@rem Object Name Without Quotes=%~0
@rem Bat File Drive = %~d0
@rem Full File Name = %~n0%~x0
@rem File Name Without Extension = %~n0
@rem File Extension = %~x0

set CLI_DIRECTORY=%~dp0
set CLI_FILE=%~n0%~x0
set CLI_FILENAME=%~n0
set CLI_FILEEXTENSION=%~x0

@rem ------------------- declare CLI variable -------------------

set BREADCRUMB=cli
set COMMAND=
set COMMAND_BC_AGRS=
set COMMAND_AC_AGRS=

@rem ------------------- declare variable -------------------

for %%a in ("%cd%") do (
    set PROJECT_NAME=%%~na
)
set PROJECT_ENV=dev
set VARNUMBER1=0
set VARNUMBER2=0
set VARTEST=0

@rem ------------------- execute script -------------------

call :main %*
goto end

@rem ------------------- declare function -------------------

:main
    set COMMAND=
    set COMMAND_BC_AGRS=
    set COMMAND_AC_AGRS=
    call :argv-parser %*
    call :main-args-parser %COMMAND_BC_AGRS%
    IF defined COMMAND (
        set BREADCRUMB=%BREADCRUMB%-%COMMAND%
        findstr /bi /c:":!BREADCRUMB!" %CLI_FILE% >nul 2>&1
        IF errorlevel 1 (
            goto cli-help
        ) else (
            call :main %COMMAND_AC_AGRS%
        )
    ) else (
        call :%BREADCRUMB%
    )
    goto end

:main-args-parser
    for /f "tokens=1*" %%p in ("%*") do (
        for /f "tokens=1,2 delims==" %%i in ("%%p") do (
            call :%BREADCRUMB%-args %%i %%j
            call :common-args %%i %%j
        )
        call :main-args-parser %%q
    )
    goto end

:common-args
    set COMMON_ARGS_KEY=%1
    set COMMON_ARGS_VALUE=%2
    if "%COMMON_ARGS_KEY%"=="-h" (set BREADCRUMB=%BREADCRUMB%-help)
    if "%COMMON_ARGS_KEY%"=="--help" (set BREADCRUMB=%BREADCRUMB%-help)
    goto end

:argv-parser
    for /f "tokens=1*" %%p in ("%*") do (
        IF NOT defined COMMAND (
            echo %%p | findstr /r "\-" >nul 2>&1
            if errorlevel 1 (
                set COMMAND=%%p
            ) else (
                set COMMAND_BC_AGRS=!COMMAND_BC_AGRS! %%p
            )
        ) else (
            set COMMAND_AC_AGRS=!COMMAND_AC_AGRS! %%p
        )
        call :argv-parser %%q
    )
    goto end

@rem ------------------- Main method -------------------

:cli
    goto cli-help

:cli-args
    set COMMON_ARGS_KEY=%1
    set COMMON_ARGS_VALUE=%2
    if "%COMMON_ARGS_KEY%"=="--prod" (set PROJECT_ENV=prod)
    goto end

:cli-help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo If not input any command, at default will show HELP
    echo.
    echo Options:
    echo      --help, -h        Show more information with CLI.
    echo      --prod            Setting project environment with "prod", default is "dev"
    echo.
    echo Command:
    echo      up                Startup Server.
    echo      down              Close down Server.
    echo      into              Into Server.
    echo.
    echo Run 'cli [COMMAND] --help' for more information on a command.
    goto end

@rem ------------------- Common Command method -------------------

:cli-up-docker-prepare (
    @rem Create .env for compose
    set CONF_FILE_PATH=./conf/docker/.env
    echo Current Environment %PROJECT_ENV%
    echo PROJECT_NAME=%PROJECT_NAME% > %CONF_FILE_PATH%

    echo ^> Build Docker images
    set TARGET_DIR=%CLI_DIRECTORY%\cache\grafana-data
    IF NOT EXIST %TARGET_DIR% (
        mkdir %TARGET_DIR%
    )
    echo GF_DATA_VOLUME=%TARGET_DIR% >> %CONF_FILE_PATH%
    goto end
)


@rem ------------------- Command "up" method -------------------

:cli-up
    echo ^> Startup Grafana
    @rem Execute prepare action
    call :cli-up-docker-prepare

    @rem Run next deveopment with stdout
    docker-compose -f ./conf/docker/docker-compose.yml --env-file ./conf/docker/.env up -d
    goto end

:cli-up-args
    set COMMON_ARGS_KEY=%1
    set COMMON_ARGS_VALUE=%2
    if "%COMMON_ARGS_KEY%"=="--var1" (set VARNUMBER1=%COMMON_ARGS_VALUE%)
    goto end

:cli-up-help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup Server
    echo.
    echo Command:
    echo      demo              Show demo info.
    echo Options:
    echo      --help, -h        Show more information with UP Command.
    goto end

@rem ------------------- Command "into" method -------------------

:cli-into
    echo ^> Into Grafana : docker-grafana_%PROJECT_NAME%
    docker exec -ti docker-grafana_%PROJECT_NAME% bash
    goto end

:cli-into-args
    goto end

:cli-into-help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Into Server
    echo.
    echo Command:
    echo      demo              Show demo info.
    echo Options:
    echo      --help, -h        Show more information with UP Command.
    goto end

@rem ------------------- Command "down" method -------------------

:cli-down
    echo ^> Close Down Grafana
    docker-compose -f ./conf/docker/docker-compose.yml --env-file ./conf/docker/.env down
    goto end

:cli-down-args
    goto end

:cli-down-help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Close down Server
    echo.
    echo Options:
    echo      --help, -h        Show more information with UP Command.
    goto end

@rem ------------------- End method-------------------

:end
    endlocal
