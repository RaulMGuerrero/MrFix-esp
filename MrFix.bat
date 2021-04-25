@echo off

:: Comprobación de inicio como administrador.
net session >nul 2>&1
if %errorLevel% == 0 (
        echo ### Running as administrator
    ) else (
        color A
		echo ### Permiso denegado, inicie la aplicacion como ADMINISTRADOR. ###
        echo.
        echo.
        echo *******************************************************************
        pause
        GOTO END
    )


:: Bienvenida y tamaño
TITLE Bienvenid@ a MrFix, %USERNAME%.
MODE con:cols=90 lines=35

:: Tipografia de menus --> http://patorjk.com/software/taag/#p=display&c=echo&f=Small%20Slant&t=Menu%0AHerramientas
:inicio
color A
SET var=0
SET opc=select
cls
echo Programa Creado por Raul M. Guerrero - @t3cn00b
echo.
echo.
echo           [..       [..[........[...     [..[..     [..
echo           [. [..   [...[..      [. [..   [..[..     [..
echo           [.. [.. [ [..[..      [.. [..  [..[..     [..   
echo           [..  [..  [..[......  [..  [.. [..[..     [..
echo           [..   [.  [..[..      [..   [. [..[..     [..
echo           [..       [..[..      [..    [. ..[..     [..
echo           [..       [..[........[..      [..  [.....   
echo.                                       
echo #####################################################################
echo ^| 1    Copiar DOCUMENTOS, DESCARGAS, IMAGENES, ESCRITORIO Y VIDEOS  ^|
echo ^| 2    Restaurar DOCUMENTOS, DESCARGAS, IMAGENES, ESCRITORIO        ^|
echo ^| 3    Escanear y recuperar sectores def. ^del disco duro (NO SSD)   ^|
echo ^| 4    Descargar programas libres                                   ^|
echo ^| 5    Buscar errores de eficiencia energetica                      ^|
echo ^| 6    Reparar archivos de Windows                                  ^|
echo ^| 7    Liberar espacio en disco/s                                   ^|
echo ^| 8    Hacer backup de los drivers                                  ^|
echo ^| 9    ^Ver Licencia de Windows                                      ^|
echo ^| Q    Salir                                                        ^|
echo #####################################################################
echo.
SET /p var= ^> Seleccione una opcion [1-0]:
echo.
if "%var%"=="0" goto inicio
if "%var%"=="1" goto op1
if "%var%"=="2" goto op2
if "%var%"=="3" goto op3
if "%var%"=="4" goto op4
if "%var%"=="5" goto op5
if "%var%"=="6" goto op6
if "%var%"=="7" goto op7
if "%var%"=="8" goto op8
if "%var%"=="9" goto op9
if "%var%"=="Q" goto salir
if "%var%"=="q" goto salir

:: Mensaje de error, validación cuando se selecciona una opción fuera de rango
cls

echo.
echo.
echo.
echo.
echo                        ============Opcon Invalida=============
echo                        ---------------------------------------
echo                        Seleccione la opcion correcta:
echo                        Menu [1-9] o seleccione '0' para salir.
echo                        ---------------------------------------
echo                        ====Pulse cualquier para continuar======

PAUSE > NUL
GOTO :inicio

:op1
    echo.
    echo.
	color 4
	cls
        echo.
		echo ####################################################################################
		echo ATENCION! Para no interferir en el proceso, cierre todos los programas y documentos
		echo antes de pulsar cualquier tecla....
		echo ####################################################################################
		echo.
		pause
		color F
setlocal EnableDelayedExpansion
:: variables
set destination=C:\Backup
set xcopyswitches=/s /e /h /i /y

echo/

:: Contador
set /a n=0

:: Directorios para Backup
set user_directories=Documents Downloads Pictures Desktop Videos
for %%a in (%user_directories%) do (
	set dest_directories[!n!]=%%a
	set sour_directories[!n!]="%USERPROFILE%\%%a"
	set /a n = n + 1
)

:: para añadir directorios adicionales:
:: 1. añada la carpeta de destino a la matriz dest_directories (utilice %n% como contador)
:: 2. añada la carpeta de origen a la matriz sour_directories (de nuevo, utilice %n%)
:: 3. aumentar la variable n en 1

::set directorios_dest[!n!]=PowerShell
::set sour_directories[!n!]="C:\NArchivos de programa (x86)\NWindowsPowerShell"
::set /a n = n + 1

:: Elimina el último elemento
set /a n = n -1

:: Comienzo de la copia
echo El backup está comenzando, un momento por favor.....
echo/
echo/
for /L %%i in (0,1,%n%) do (
	echo Directory: !sour_directories[%%i]!
	xcopy !sour_directories[%%i]! "%destination%\!dest_directories[%%i]!" %xcopyswitches%
	echo/
)
echo/
	cls
    color A
	    echo.
		echo #########################################################################################
		echo COPIA COMPLETADA %date% ^| %time% 
		echo Se ha creado una carpeta en "C:/Backup" con la copia de sus carpetas y archivos.
		echo Si desea copiarlos en otro ordenador, copie esa carpeta en C:/Backup del nuevo PC.
		echo #########################################################################################
		echo.
    pause
    goto:inicio

:op2
    echo.
    echo.
	color 4
	cls
        echo.
		echo ######################################################################################
		echo Si este es un ordenador nuevo, recuerde ejecutar la copia de nuevo para tener todos
		echo sus archivos mas actuales.
		echo Antes de restaurar sus archivos, copie la carpeta "Backup" en el Escritorio. 
		echo Si no lo has hecho, puedes cerrar esta ventana pulsando la [X] de arriba a la derecha.
		echo ######################################################################################
		echo.
		pause

        :: Variables
        SET BACKUPDIR=C:\Backup
		color F
        xcopy "%BACKUPDIR%\Documents" "%userprofile%\Documents" /s /e /h /i /y
        xcopy "%BACKUPDIR%\Downloads" "%userprofile%\Downloads" /s /e /h /i /y
        xcopy "%BACKUPDIR%\Pictures" "%userprofile%\Pictures" /s /e /h /i /y
        xcopy "%BACKUPDIR%\Desktop" "%userprofile%\Desktop" /s /e /h /i /y
        xcopy "%BACKUPDIR%\Videos" "%userprofile%\Videos" /s /e /h /i /y
        xcopy "%BACKUPDIR%\Drivers" "%userprofile%\Desktop\Drivers" /s /e /h /i /y
		cls
    color A
	    echo.
		echo ############################################
		echo COPIA COMPLETADA %date% ^| %time% 
		echo Revise si estan todos sus documentos.
		echo La copia se ha hecho en las mismas carpetas.
		echo ############################################
		echo.
    pause
    goto:inicio

:op3
    echo.
    echo.
	color 0b
	cls
        echo.
		echo ####################################################################################
		echo Se va a ejecutar un analisis del disco duro y recuperacion de sectores defectuosos. 
		echo Espere a que el ordenadore reinicie y deje que el proceso termine.
		echo Este proceso puede tardar varios minutos.
		echo ####################################################################################
		echo.
		pause
		chkdsk C: /F /R
		cls
    color 4
	    echo.
		echo ############################################################################################
		echo ATENCION AL PULSAR UNA TECLA EL EQUIPO SE REINICIARA. ¡GUARTE TODOS SUS DOCUMENTOS!
		echo ############################################################################################
		echo.
	pause
		shutdown -r 
    goto:salir
  
:op4
    echo.
    echo. VAMOS!.
    echo.
        start https://www.ninite.com
    echo.
    goto:inicio

:op5
    echo.
    echo. Eficiencia energetica
    echo.
	cls
	color E
	powercfg /ENERGY -OUTPUT %userprofile%\Documentos\energy-report.html
	start %userprofile%\Documentos\energy-report.html
    echo.
	pause
    goto:inicio
	
:op6
    echo.
    echo. Reparacion de archivos del sistema
    echo.
  color 4
	    echo.
		echo ###################################################################################################
		echo Se va a proceder a escanear y reparar el sistema, cierre y guarde todos sus programas o documentos.
		echo ###################################################################################################
		echo.
	pause
        sfc /scannow
    echo.
    goto:inicio
	
:op7
    echo.
    echo. Liberar espacio en disco/s
    echo.
        Cleanmgr
    echo.
    goto:inicio

:op8
    mkdir C:\Backup\Drivers
    dism /online /export-driver /destination:C:\Backup\Drivers
    cls

    pause
    goto :inicio

:op9
	cls
    echo Su clave de Windows es:
    wmic path softwarelicensingservice get OA3xOriginalProductKey
    echo Utilice la opcion "marcar" y luego "copiar" en esta misma ventana para copiar su clave.
    pause
    cls
    echo.
    echo.
    :inactwin
    color A
	echo.
	echo Presione 1 para activar su clave ahora o 2 para ir al menu.
	CHOICE /C:12 /N
	IF %ERRORLEVEL% ==1 GOTO :actw
	IF %ERRORLEVEL% ==2 GOTO :inicio
goto :inicio

:actw
    slui.exe
    goto :inicio

:salir
	cls
	echo.
	echo.
	echo.
    echo			" ____ ____ ____ ____ ____ "
    echo			"||A |||D |||I |||O |||S ||"
    echo			"||__|||__|||__|||__|||__||"
    echo			"|/__\|/__\|/__\|/__\|/__\|"
	echo.
	echo.
	echo.
	echo.
	echo.
	echo.
	timeout /T 2
    @cls&exit 
::Programa Creado por Raul M. Guerrero - @t3cn00b