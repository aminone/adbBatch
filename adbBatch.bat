::adbBatch version 1.0 is a handy tool for use some ADB(Android Debug Bridge) Commands easily
::Copy right (c) Amix 2014
::
::This program is free software: you can redistribute it and/or modify
::it under the terms of the GNU General Public License as published by
::the Free Software Foundation, either version 3 of the License, or
::(at your option) any later version.
::
::This program is distributed in the hope that it will be useful,
::but WITHOUT ANY WARRANTY; without even the implied warranty of
::MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
::GNU General Public License for more details.
::
::You should have received a copy of the GNU General Public License
::along with this program.  If not, see <http://www.gnu.org/licenses/>.

@ECHO OFF
CLS

:START
IF EXIST %CD%\pathOfADB.txt (
set /p adbPath=<%CD%\pathOfADB.txt
GOTO :CHECKPATH
) ELSE (
ECHO NA >%CD%\pathOfADB.txt
GOTO :START
)

:: ____________________________________________________________________	
:CHECKPATH
IF %adbPath%==NA (
GOTO :SECTION81
)

:: ____________________________________________________________________	
:MENU
CLS

ECHO 		=-=-=-=-=-=-= SELECT COMMAND =-=-=-=-=-=-=
ECHO 		------------------------------------------
ECHO 		1.  KILL SERVER
ECHO 		2.  START SERVER
ECHO 		3.  DEVICES LIST
ECHO 		4.  INSTALL AN APK...
ECHO 		5.  SCREEN INFORMATION...
ECHO 		6.  ADB SHELL
ECHO 		7.  ADB VERSION
ECHO 		8.  ADB PATH...
ECHO 		9.  EXIT
ECHO 		__________________________________________
ECHO 		_________________BY_AMIX__________________
ECHO 		=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=

set /p choice=Select your command: 

::if not /I %choice%== set choice=%choice:~0,1% 
if /I %choice%==1 goto :SECTION1
if /I %choice%==2 goto :SECTION2
if /I %choice%==3 goto :SECTION3
if /I %choice%==4 goto :SECTION4
if /I %choice%==5 goto :SECTION5
if /I %choice%==6 goto :SECTION6
if /I %choice%==7 goto :SECTION7
if /I %choice%==8 goto :SECTION8
if /I %choice%==9 goto :QUIT
ECHO "%choice%" is not a valid option. Please try again. 
ECHO
goto MENU 

:: ____________________________________________________________________	
:SECTION1
CLS
"%adbPath%" kill-server
ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION2
CLS
"%adbPath%" start-server
ECHO "PRESS ANY KEY TO <EXIT>"
PAUSE>NUL
EXIT

:: ____________________________________________________________________	
:SECTION3
CLS
"%adbPath%" devices
ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION4
CLS
ECHO 		=-=-=-=-=-=-= SELECT COMMAND =-=-=-=-=-=-=-=-=
ECHO 		----------------------------------------------
ECHO 		1.  INSTALL TO THE +ONLY+ RUNNING EMULATOR
ECHO 		2.  INSTALL TO THE +ONLY+ CONNECTED USB DEVICE
ECHO 		3.  BACK
ECHO 		______________________________________________
ECHO 		=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=
set /p apkChoice=Select one : 
if /I %apkChoice%==1 goto :SECTION41
if /I %apkChoice%==2 goto :SECTION42
if /I %apkChoice%==3 goto :MENU
ECHO "%apkChoice%" is not a valid option. Please try again. 
ECHO
goto SECTION4 

:: ____________________________________________________________________	
:SECTION41
CLS
ECHO INSTALL TO THE ONLY RUNNING EMULATOR
set /p apkPath1=Enter your APK path : 
"%adbPath%" -e install %apkPath1%
ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION42
CLS
ECHO INSTALL TO THE ONLY CONNECTED USB DEVICE
set /p apkPath2=Enter your APK path : 
"%adbPath%" -d install %apkPath2%
ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION5
CLS
ECHO 		=-=-=-=-=-=-= SELECT COMMAND =-=-=-=-=-=-=-=-=
ECHO 		----------------------------------------------
ECHO 		1.  GET SCREEN SIZE
ECHO 		2.  GET SCREEN DENSITY
ECHO 		3.  BACK
ECHO 		______________________________________________
ECHO 		=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=
set /p screenChoice=Select one : 
if /I %screenChoice%==1 goto :SECTION51
if /I %screenChoice%==2 goto :SECTION52
if /I %screenChoice%==3 goto :MENU
ECHO "%screenChoice%" is not a valid option. Please try again. 
ECHO
goto SECTION5 

:: ____________________________________________________________________	
:SECTION51
CLS
ECHO Getting Size... 
"%adbPath%" shell wm size
ECHO PRESS ANY KEY TO GO BACK
PAUSE>NUL
goto SECTION5

:: ____________________________________________________________________	
:SECTION52
CLS
ECHO Getting Density...
"%adbPath%" shell getprop ro.sf.lcd_density
ECHO PRESS ANY KEY TO GO BACK
PAUSE>NUL
goto SECTION5

:: ____________________________________________________________________	
:SECTION6
CLS
"%adbPath%" shell
ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION7
CLS
"%adbPath%" version
ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION8
CLS
ECHO 		=-=-=-=-=-=-= SELECT COMMAND =-=-=-=-=-=-=-=-=
ECHO 		----------------------------------------------
ECHO 		1.  SET ADB PATH
ECHO 		2.  SHOW ADB PATH
ECHO 		3.  BACK
ECHO 		______________________________________________
ECHO 		=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=

set /p adbPathChoice=Select one: 

if /I %adbPathChoice%==1 goto :SECTION81
if /I %adbPathChoice%==2 goto :SECTION82
if /I %adbPathChoice%==3 goto :START
ECHO "%adbPathChoice%" is not a valid option. Please try again. 
ECHO
goto SECTION8

:: ____________________________________________________________________	
:SECTION81
CLS
set /p adbPath=Enter the path of your ADB: 
ECHO %adbPath% > "%CD%"\pathOfADB.txt
ECHO PRESS ANY KEY TO GO BACK
PAUSE>NUL
goto SECTION8

:: ____________________________________________________________________	
:SECTION82
CLS
ECHO %adbPath%
ECHO PRESS ANY KEY TO GO BACK
PAUSE>NUL
goto SECTION8

:: ____________________________________________________________________	
:QUIT
CLS
EXIT