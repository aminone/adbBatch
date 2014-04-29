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
GOTO :SECTION101
)

:: ____________________________________________________________________	
:MENU
CLS

ECHO 		=-=-=-=-=-=-= SELECT COMMAND =-=-=-=-=-=-=
ECHO 		------------------------------------------
ECHO 		 1._____Kill Server_______________________
ECHO 		 2._____Start Server______________________
ECHO 		 3._____Devices List______________________
ECHO 		 4._____Device Informations_______________
ECHO 		 5._____Wireless Debugging..._____________
ECHO 		 6._____Install an APK..._________________
ECHO 		 7._____Screen Informations...____________
ECHO 		 8._____ADB Shell_________________________
ECHO 		 9._____ADB Version_______________________
ECHO 		10._____ADB Path..._______________________
ECHO 		 0._____EXIT______________________________
ECHO 		__________________________________________
ECHO 		_________________BY_AMIX__________________
ECHO 		=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=

set /p choice=Select your command: 

if /I %choice%==1 goto :SECTION1
if /I %choice%==2 goto :SECTION2
if /I %choice%==3 goto :SECTION3
if /I %choice%==4 goto :SECTION4
if /I %choice%==5 goto :SECTION5
if /I %choice%==6 goto :SECTION6
if /I %choice%==7 goto :SECTION7
if /I %choice%==8 goto :SECTION8
if /I %choice%==9 goto :SECTION9
if /I %choice%==10 goto :SECTION10
if /I %choice%==0 goto :QUIT
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
ECHO Information About your
"%adbPath%" shell getprop ro.product.model
ECHO ----------------------------------------------
ECHO.
"%adbPath%" shell cat /system/build.prop | find "product"
ECHO.
ECHO "PRESS ANY KEY TO GO BACK"
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION5
CLS
ECHO 		=-=-=-=-=-=-= SELECT COMMAND =-=-=-=-=-=-=-=-=
ECHO 		----------------------------------------------
ECHO 		1.  CONNECT A DEVICE...
ECHO 		2.  DISCONNECT DEVICE(S)...
ECHO 		3.  BACK
ECHO 		______________________________________________
ECHO 		=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=

set /p choice=Select one: 

if /I %choice%==1 goto :SECTION51
if /I %choice%==2 goto :SECTION52
if /I %choice%==3 goto :START
ECHO "%choice%" is not a valid option. Please try again. 
ECHO
goto SECTION5

:: ____________________________________________________________________	
:SECTION51
CLS
ECHO MAKE SURE YOUR DEVICE IS IN THE SAME RANGE OF YOUR PC NETWORK.
ECHO ATTACH USB CABLE.
set /p ipaddress=Enter your device IP address : 
"%adbPath%" tcpip 5555 & "%adbPath%" connect %ipaddress%:5555
ECHO NOW YOU CAN DETACH THE USB CABLE.
ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION52
CLS
ECHO 		=-=-=-=-=-=-= SELECT COMMAND =-=-=-=-=-=-=-=-=
ECHO 		----------------------------------------------
ECHO 		1.  DISCONNECT SPECIFIC DEVICE...
ECHO 		2.  DISCONNECT ALL DEVICES
ECHO 		3.  BACK
ECHO 		______________________________________________
ECHO 		=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=

set /p choice=Select one: 

if /I %choice%==1 goto :SECTION521
if /I %choice%==2 goto :SECTION522
if /I %choice%==3 goto :SECTION5
ECHO "%choice%" is not a valid option. Please try again. 
ECHO
goto SECTION52

:: ____________________________________________________________________	
:SECTION521
CLS

set /p ipaddress=Enter your device IP address : 
"%adbPath%" disconnect %ipaddress%:5555

ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION522
CLS

"%adbPath%" disconnect

ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION6
CLS
ECHO 		=-=-=-=-=-=-= SELECT COMMAND =-=-=-=-=-=-=-=-=
ECHO 		----------------------------------------------
ECHO 		1.  INSTALL TO THE +ONLY+ RUNNING EMULATOR
ECHO 		2.  INSTALL TO THE +ONLY+ CONNECTED USB DEVICE
ECHO 		3.  BACK
ECHO 		______________________________________________
ECHO 		=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=
set /p apkChoice=Select one: 
if /I %apkChoice%==1 goto :SECTION61
if /I %apkChoice%==2 goto :SECTION62
if /I %apkChoice%==3 goto :MENU
ECHO "%apkChoice%" is not a valid option. Please try again. 
ECHO
goto SECTION5 

:: ____________________________________________________________________	
:SECTION61
CLS
ECHO INSTALL TO THE ONLY RUNNING EMULATOR
set /p apkPath1=Enter your APK path : 
"%adbPath%" -e install %apkPath1%
ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION62
CLS
ECHO INSTALL TO THE ONLY CONNECTED USB DEVICE
set /p apkPath2=Enter your APK path : 
"%adbPath%" -d install %apkPath2%
ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION7
CLS
ECHO 		=-=-=-=-=-=-= SELECT COMMAND =-=-=-=-=-=-=-=-=
ECHO 		----------------------------------------------
ECHO 		1.  GET SCREEN SIZE
ECHO 		2.  GET SCREEN DENSITY
ECHO 		3.  BACK
ECHO 		______________________________________________
ECHO 		=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=
set /p screenChoice=Select one: 
if /I %screenChoice%==1 goto :SECTION71
if /I %screenChoice%==2 goto :SECTION72
if /I %screenChoice%==3 goto :MENU
ECHO "%screenChoice%" is not a valid option. Please try again. 
ECHO
goto SECTION7 

:: ____________________________________________________________________	
:SECTION71
CLS
ECHO Getting Size... 
"%adbPath%" shell wm size
ECHO PRESS ANY KEY TO GO BACK
PAUSE>NUL
goto SECTION7

:: ____________________________________________________________________	
:SECTION72
CLS
ECHO Getting Density...
"%adbPath%" shell getprop ro.sf.lcd_density
ECHO PRESS ANY KEY TO GO BACK
PAUSE>NUL
goto SECTION7

:: ____________________________________________________________________	
:SECTION8
CLS
"%adbPath%" shell
ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION9
CLS
"%adbPath%" version
ECHO PRESS ANY KEY TO CONTINUE
PAUSE>NUL
goto MENU

:: ____________________________________________________________________	
:SECTION10
CLS
ECHO 		=-=-=-=-=-=-= SELECT COMMAND =-=-=-=-=-=-=-=-=
ECHO 		----------------------------------------------
ECHO 		1.  SET ADB PATH
ECHO 		2.  SHOW ADB PATH
ECHO 		3.  BACK
ECHO 		______________________________________________
ECHO 		=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=

set /p adbPathChoice=Select one: 

if /I %adbPathChoice%==1 goto :SECTION101
if /I %adbPathChoice%==2 goto :SECTION102
if /I %adbPathChoice%==3 goto :START
ECHO "%adbPathChoice%" is not a valid option. Please try again. 
ECHO
goto SECTION10

:: ____________________________________________________________________	
:SECTION101
CLS
set /p adbPath=Enter the path of your ADB: 
ECHO %adbPath% > "%CD%"\pathOfADB.txt
ECHO PRESS ANY KEY TO GO BACK
PAUSE>NUL
goto SECTION10

:: ____________________________________________________________________	
:SECTION102
CLS
ECHO Your current adb path:
ECHO %adbPath%
ECHO PRESS ANY KEY TO GO BACK
PAUSE>NUL
goto SECTION10

:: ____________________________________________________________________	
:QUIT
CLS
EXIT