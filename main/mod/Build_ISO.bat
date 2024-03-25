@echo off
Setlocal EnableDelayedExpansion
 
::begin
:BEGIN
cls
echo ========================================
echo ======NSMBW Mod ISO Builder v1.04=======
echo ========================================
echo ===Builder by damysteryman/Team DARK====
echo ========Powered by WIT by Wiimm=========
echo ========More info in README.txt=========
echo ========================================
pause

:: Mod Select Menu
cls
echo ===============================NSMBW Mod Select================================
echo 1. Newer SMBW                           
echo    http://www.newerteam.com/getNewerFile.php
echo.
echo 2. Cannon SMBW (Not support JPNv2)                      
echo    https://dl.dropbox.com/u/74278297/Cannon_Super_Mario_Bros._Wii_v1.1.zip
echo.                                        
echo 3. Another SMBW (Supports only USAv1 USAv2 EURv1)
echo    http://dirbaio.net/newer/Another_Super_Mario_Brothers_Wii_2.0.zip
echo.
echo 4. Newer Summer Sun (Not support JPNv2)
echo    http://dirbaio.net/newer/Newer_Summer_Sun.zip
echo.
echo 5. Newer Holiday Special
echo    http://dirbaio.net/newer/Newer_Super_Mario_Bros._Wii_HS.zip
echo.
echo 6. Epic Super Bowser World
echo    https://dl.dropbox.com/u/74278297/Epic_Super_Bowser_World_v1.00.zip
::echo.
::echo 7. Retro Remix
::echo    http://dl.dropbox.com/u/24613988/Packages/Retro Remix.rar
echo.
echo ========================Enter the Number corresponding=========================
echo =============================to the Mod you want===============================
SET MODINPUT=
SET /P MODINPUT=Enter Number and press Enter:

IF %MODINPUT%==1 (
	SET MOD=Newer
	GOTO VERSELECT
	)
IF %MODINPUT%==2 (
	SET MOD=Cannon
	GOTO VERSELECT
	)
IF %MODINPUT%==3 (
	SET MOD=Another
	GOTO VERSELECT
	)
IF %MODINPUT%==4 (
	SET MOD=SummerSun
	GOTO VERSELECT
	)
IF %MODINPUT%==5 (
	SET MOD=HolidaySpecial
	GOTO VERSELECT
	)
IF %MODINPUT%==6 (
	SET MOD=EpicSuperBowserWorld
	GOTO VERSELECT
	)
::IF %MODINPUT%==7 (
::	SET MOD=RetroRemix
::	GOTO VERSELECT
::	)
GOTO INPUTERROR

:VERSELECT
:: Version Select Menu
cls
echo ========Base ISO Version Select=========
echo 0. Autodetect!
echo 1. EUR v1
echo 2. EUR v2
echo 3. USA v1
echo 4. USA v2
echo 5. JPN v1
echo  . JPN v2 (still not supported atm...)
echo.
echo JPNv2 support still not implemented.
echo Mods do not support KOR or TWN versions.
echo.
echo =====Enter the Number corresponding=====
echo ======to your NSMBW image verison=======
SET VERINPUT=
SET /P VERINPUT=Enter Number and press Enter:

IF %VERINPUT%==0 (
	SET BASEVER=AUTO
	GOTO EXTSELECT
	)
IF %VERINPUT%==1 (
	SET BASEVER=EURv1
	SET GAMEID=SMNP01
	GOTO EXTSELECT
	)
IF %VERINPUT%==2 (
	SET BASEVER=EURv2
	SET GAMEID=SMNP01
	GOTO EXTSELECT
	)
IF %VERINPUT%==3 (
	SET BASEVER=USAv1
	SET GAMEID=SMNE01
	GOTO EXTSELECT
	)
IF %VERINPUT%==4 (
	SET BASEVER=USAv2
	SET GAMEID=SMNE01
	GOTO EXTSELECT
	)
IF %VERINPUT%==5 (
	SET BASEVER=JPNv1
	SET GAMEID=SMNJ01
	GOTO EXTSELECT
	)
::IF %VERINPUT%==6 (
::	SET BASEVER=JPNv2
::	SET GAMEID=SMNJ01
::	GOTO EXTSELECT
::	)

GOTO INPUTERROR

:EXTSELECT
cls
echo ========Newer ISO Format Select=========
echo 1. .iso
echo 2. .wbfs
echo =====Enter the Number corresponding=====
echo ========to the filetype you want========
SET EXTINPUT=
SET /P EXTINPUT=Enter Number and press Enter:

IF %EXTINPUT%==1 (
	SET FILEEXT=iso
	GOTO SAVESELECT
	)
IF %EXTINPUT%==2 (
	SET FILEEXT=wbfs
	GOTO SAVESELECT
	)

GOTO INPUTERROR

:SAVESELECT
cls
echo =========Newer Save "Slot" Select=========
echo 1. Original (SMNx)
echo Original NSMBW save is unaltered, but both
echo both are in same "slot" in Data Management
echo.
echo 2. Custom, Shared (KMNx)
echo Store save under a different custom "slot"
echo in Data Management away from original
echo.
echo 3. Custom, Individual (KMyx)
echo Store save under different custom "slot",
echo a separate one for each mod
echo.
echo ======Enter the Number corresponding======
echo ==========to the "slot" you want==========
SET SLOTINPUT=
SET /P SLOTINPUT=Enter Number and press Enter:

IF %SLOTINPUT%==1 (
	SET SLOT=Original
	GOTO BANNER
	)
IF %SLOTINPUT%==2 (
	SET SLOT=Custom-Shared
	GOTO BANNER
	)
IF %SLOTINPUT%==3 (
	SET SLOT=Custom-Individual
	GOTO BANNER
	)
GOTO INPUTERROR

:BANNER
cls
echo =======Custom Banner File Download========
echo 1. Yes
echo (Anything else). No, use saved custom
echo (or no custom if not found)
echo ==========================================
SET BANNERDL=
SET /P BANNERDL=Enter Number and press Enter:
GOTO DOUBLECHECK

:DOUBLECHECK
cls
echo ==============Review Settings=============
echo Selected NSMBW Mod: %MOD%
echo Selected Base Version: %BASEVER%
echo Selected Output Filetype: %FILEEXT%
echo Selected Save "Slot": %SLOT%
IF %BANNERDL%==1 (
echo Download Custom Banner: Yes
) ELSE (
echo Download Custom Banner: No, use existing
)
echo.
echo ===========Is this selection ok?==========
echo 1. Yes, continue
echo 2. No, change settings
echo (Anything else). exit
echo ==========================================
SET AREYOUSURE=
SET /P AREYOUSURE=Enter Number and press Enter:

IF %AREYOUSURE%==1 GOTO EXTRACT
IF %AREYOUSURE%==2 GOTO BEGIN

GOTO INPUTERROR

:INPUTERROR
echo Invalid option selected, exiting...
pause
exit

:DETECTEDVER
::Exit if supported version is not found (BASEVER not reset)
IF %BASEVER%==AUTO (
	echo Unsupported ISO version detected, exiting...
	rmdir nsmb.d /s /q
	pause
	exit
	)

echo.
echo Autodetected Base ISO Version: %BASEVER%
GOTO CONTINUE

:EXTRACT
:: Check for Mod contents folder and riivolution xml before anything
echo.
echo Checking for %MOD% resources...
IF %MOD%==Newer (
	SET MODFOLDER=NewerSMBW
	SET MODFOLSRC=NewerSMBW.zip\NewerFiles\NewerSMBW\
	SET XML=NewerSMBW
	)
IF %MOD%==Cannon (
	SET MODFOLDER=Cannon
	SET MODFOLSRC=Cannon_Super_Mario_Bros_Wii_v1.1.zip\Cannon_Super_Mario_Bros_Wii_v1.1\Cannon\
	SET XML=CannonP
	)
IF %MOD%==Another (
	SET MODFOLDER=Another
	SET MODFOLSRC=Another_Super_Mario_Brothers_Wii_2.0.zip\Another\
	SET XML=Another
	)
IF %MOD%==SummerSun (
	SET MODFOLDER=SumSun
	SET MODFOLSRC=Newer_Summer_Sun.zip\Newer Summer Sun\SumSun\
	SET XML=SumSunP
	)
IF %MOD%==HolidaySpecial (
	SET MODFOLDER=XmasNewer
	SET MODFOLSRC=Newer_Super_Mario_Bros._Wii_HS.zip\XmasNewer\
	)
IF %MOD%==EpicSuperBowserWorld (
	SET MODFOLDER=ESBW
	SET MODFOLSRC=Epic_Super_Bowser_World_v1.00.zip\Epic_Super_Bowser_World_v1.00\ESBW\
	SET XML=ESBWP
	)
IF %MOD%==RetroRemix (
	SET MODFOLDER=Retro Remix
	SET MODFOLSRC=Retro Remix\Retro Remix\
	)
IF NOT EXIST "%MODFOLDER%\" (
	echo.
	echo Cannot find the "%MODFOLDER%" folder containing %MOD% files, exiting...
	echo.
	echo Please make sure you have "%MODFOLDER%" in the same directory
	echo as this builder pack.
	echo [%MODFOLSRC%] ^<- This one!
	echo.
	pause
	exit
	) ELSE (
	echo.
	echo %MOD% files found, continuing...
	)
	
IF %MOD%==HolidaySpecial GOTO SKIPXMLCHECK
IF %MOD%==RetroRemix GOTO SKIPXMLCHECK

IF /I NOT EXIST riivolution\%XML%.xml (
	echo.
	echo Cannot find \riivolution\%XML%.xml containing %MOD% patches, exiting...
	echo.
	pause
	exit
	) ELSE (
	echo.
	echo %MOD% patches found, continuing...
	)

:SKIPXMLCHECK
:: extract image
:: Autodetect
IF %BASEVER%==AUTO (
echo.
echo Unpacking original game...
wit\wit extract -s ../ -1 -n SMN.01 . nsmb.d --psel=DATA -ovv

:Detect version and assign BASEVER
IF EXIST nsmb.d\files\COPYDATE_LAST_2009-10-03_232911 (
	SET BASEVER=EURv1
	SET GAMEID=SMNP01
	)
IF EXIST nsmb.d\files\COPYDATE_LAST_2010-01-05_152101 (
	SET BASEVER=EURv2
	SET GAMEID=SMNP01
	)
IF EXIST nsmb.d\files\COPYDATE_LAST_2009-10-03_232303 (
	SET BASEVER=USAv1
	SET GAMEID=SMNE01
	)
IF EXIST nsmb.d\files\COPYDATE_LAST_2010-01-05_143554 (
	SET BASEVER=USAv2
	SET GAMEID=SMNE01
	)
IF EXIST nsmb.d\files\COPYDATE_LAST_2009-10-03_231655 (
	SET BASEVER=JPNv1
	SET GAMEID=SMNJ01
	)
GOTO DETECTEDVER
) ELSE (
:: Not Autodetect
echo.
echo Unpacking original game...
wit\wit extract -s ../ -1 -n %GAMEID% . nsmb.d --psel=DATA -ovv
)

:CONTINUE
IF %MOD%==HolidaySpecial (
IF %GAMEID%==SMNP01 SET XML=XmasP
IF %GAMEID%==SMNE01 SET XML=XmasE
IF %GAMEID%==SMNJ01 SET XML=XmasJ
IF /I NOT EXIST riivolution\!XML!.xml (
	echo Cannot find \riivolution\!XML!.xml containing %MOD% patches, exiting...
	rmdir nsmb.d /s /q
	pause
	exit
	)
)

IF %SLOTINPUT%==3 (
	SET MSGPATH=MessagePatches\
	IF %GAMEID%==SMNP01 SET RG=EU
	IF %GAMEID%==SMNE01 SET RG=US
	IF %GAMEID%==SMNJ01 SET RG=JP
	)

:: many copy commands
echo.
echo Copying %MOD% files over originals...
IF %MOD%==Newer GOTO NEWER
IF %MOD%==Cannon GOTO CANNON
IF %MOD%==Another GOTO ANOTHER
IF %MOD%==SummerSun GOTO SUMMERSUN
IF %MOD%==HolidaySpecial GOTO HOLIDAY
IF %MOD%==EpicSuperBowserWorld GOTO ESBW
IF %MOD%==RetroRemix GOTO RETRO

:NEWER
copy /b NewerSMBW\Tilesets\ nsmb.d\files\Stage\Texture\
copy /b NewerSMBW\TitleReplay\ nsmb.d\files\Replay\title\
copy /b NewerSMBW\BGs\ nsmb.d\files\Object\
copy /b NewerSMBW\SpriteTex\ nsmb.d\files\Object\
copy /b NewerSMBW\Layouts\ nsmb.d\files\Layout\
mkdir nsmb.d\files\Sound\new
copy /b NewerSMBW\Music\ nsmb.d\files\Sound\new\
mkdir nsmb.d\files\Sound\new\sfx
copy /b NewerSMBW\Music\sfx\ nsmb.d\files\Sound\new\sfx\
copy /b NewerSMBW\Music\stream nsmb.d\files\Sound\stream\
copy /b NewerSMBW\Music\rsar\ nsmb.d\files\Sound\

IF %GAMEID%==SMNP01 (
copy /b NewerSMBW\Font\ nsmb.d\files\EU\EngEU\Font\
copy /b NewerSMBW\Font\ nsmb.d\files\EU\FraEU\Font\
copy /b NewerSMBW\Font\ nsmb.d\files\EU\GerEU\Font\
copy /b NewerSMBW\Font\ nsmb.d\files\EU\ItaEU\Font\
copy /b NewerSMBW\Font\ nsmb.d\files\EU\SpaEU\Font\
copy /b NewerSMBW\Message\ nsmb.d\files\EU\EngEU\Message\
copy /b NewerSMBW\Message\ nsmb.d\files\EU\FraEU\Message\
copy /b NewerSMBW\Message\ nsmb.d\files\EU\GerEU\Message\
copy /b NewerSMBW\Message\ nsmb.d\files\EU\ItaEU\Message\
copy /b NewerSMBW\Message\ nsmb.d\files\EU\SpaEU\Message\
copy /b NewerSMBW\OthersP\ nsmb.d\files\EU\Layout\openingTitle\
)

IF %GAMEID%==SMNE01 (
copy /b NewerSMBW\Font\ nsmb.d\files\US\EngUS\Font\
copy /b NewerSMBW\Font\ nsmb.d\files\US\FraUS\Font\
copy /b NewerSMBW\Font\ nsmb.d\files\US\SpaUS\Font\
copy /b NewerSMBW\Message\ nsmb.d\files\US\EngUS\Message\
copy /b NewerSMBW\Message\ nsmb.d\files\US\FraUS\Message\
copy /b NewerSMBW\Message\ nsmb.d\files\US\SpaUS\Message\
copy /b NewerSMBW\OthersE\ nsmb.d\files\US\Layout\openingTitle\
)

IF %GAMEID%==SMNJ01 (
copy /b NewerSMBW\Font\ nsmb.d\files\JP\Font\
copy /b NewerSMBW\Message\ nsmb.d\files\JP\Message\
copy /b NewerSMBW\OthersJ\ nsmb.d\files\JP\Layout\openingTitle\
)

mkdir nsmb.d\files\NewerRes
copy /b NewerSMBW\NewerRes\ nsmb.d\files\NewerRes\
mkdir nsmb.d\files\LevelSamples
copy /b NewerSMBW\LevelSamples\ nsmb.d\files\LevelSamples\
copy /b NewerSMBW\Others\charaChangeSelectContents.arc nsmb.d\files\Layout\charaChangeSelectContents\charaChangeSelectContents.arc
copy /b NewerSMBW\Others\characterChange.arc nsmb.d\files\Layout\characterChange\characterChange.arc
copy /b NewerSMBW\Others\continue.arc nsmb.d\files\Layout\continue\continue.arc
copy /b NewerSMBW\Others\controllerInformation.arc nsmb.d\files\Layout\controllerInformation\controllerInformation.arc
copy /b NewerSMBW\Others\corseSelectMenu.arc nsmb.d\files\Layout\corseSelectMenu\corseSelectMenu.arc
copy /b NewerSMBW\Others\corseSelectUIGuide.arc nsmb.d\files\Layout\corseSelectUIGuide\corseSelectUIGuide.arc
copy /b NewerSMBW\Others\dateFile.arc nsmb.d\files\Layout\dateFile\dateFile.arc
copy /b NewerSMBW\Others\dateFile_OLD.arc nsmb.d\files\Layout\dateFile\dateFile_OLD.arc
copy /b NewerSMBW\Others\easyPairing.arc nsmb.d\files\Layout\easyPairing\easyPairing.arc
copy /b NewerSMBW\Others\extensionControllerNunchuk.arc nsmb.d\files\Layout\extensionControllerNunchuk\extensionControllerNunchuk.arc
copy /b NewerSMBW\Others\extensionControllerYokomochi.arc nsmb.d\files\Layout\extensionControllerYokomochi\extensionControllerYokomochi.arc
copy /b NewerSMBW\Others\fileSelectBase.arc nsmb.d\files\Layout\fileSelectBase\fileSelectBase.arc
copy /b NewerSMBW\Others\fileSelectBase_OLD.arc nsmb.d\files\Layout\fileSelectBase\fileSelectBase_OLD.arc
copy /b NewerSMBW\Others\fileSelectPlayer.arc nsmb.d\files\Layout\fileSelectPlayer\fileSelectPlayer.arc
copy /b NewerSMBW\Others\gameScene.arc nsmb.d\files\Layout\gameScene\gameScene.arc
copy /b NewerSMBW\Others\infoWindow.arc nsmb.d\files\Layout\infoWindow\infoWindow.arc
copy /b NewerSMBW\Others\miniGameCannon.arc nsmb.d\files\Layout\miniGameCannon\miniGameCannon.arc
copy /b NewerSMBW\Others\miniGameWire.arc nsmb.d\files\Layout\miniGameWire\miniGameWire.arc
copy /b NewerSMBW\Others\pauseMenu.arc nsmb.d\files\Layout\pauseMenu\pauseMenu.arc
copy /b NewerSMBW\Others\pointResultDateFile.arc nsmb.d\files\Layout\pointResultDateFile\pointResultDateFile.arc
copy /b NewerSMBW\Others\pointResultDateFileFree.arc nsmb.d\files\Layout\pointResultDateFileFree\pointResultDateFileFree.arc
copy /b NewerSMBW\Others\preGame.arc nsmb.d\files\Layout\preGame\preGame.arc
copy /b NewerSMBW\Others\select_cursor.arc nsmb.d\files\Layout\select_cursor\select_cursor.arc
copy /b NewerSMBW\Others\sequenceBG.arc nsmb.d\files\Layout\sequenceBG\sequenceBG.arc
copy /b NewerSMBW\Others\staffCredit.arc nsmb.d\files\Layout\staffCredit\staffCredit.arc
copy /b NewerSMBW\Others\stockItem.arc nsmb.d\files\Layout\stockItem\stockItem.arc
copy /b NewerSMBW\Others\stockItemShadow.arc nsmb.d\files\Layout\stockItemShadow\stockItemShadow.arc
copy /b NewerSMBW\Others\yesnoWindow.arc nsmb.d\files\Layout\yesnoWindow\yesnoWindow.arc

mkdir nsmb.d\files\Maps
copy /b NewerSMBW\Maps\ nsmb.d\files\Maps\
mkdir nsmb.d\files\Maps\Texture
copy /b NewerSMBW\Maps\Texture\ nsmb.d\files\Maps\Texture\
copy /b NewerSMBW\Stages\ nsmb.d\files\Stage\

::set mod-specific variables before patching and building
SET XML=NewerSMBW
SET PATCH=NR
IF %GAMEID%==SMNP01 SET GAMEID=SMNP03
IF %GAMEID%==SMNE01 SET GAMEID=SMNE03
IF %GAMEID%==SMNJ01 SET GAMEID=SMNJ03
SET MODNAME=Newer SMBW

IF %SLOTINPUT%==3 (
	SET SLOT=KMN
	copy /b SaveBanners\Newer\%RG%\save_banner\ nsmb.d\files\%RG%\save_banner\
	)

GOTO PATCH

:CANNON
copy /b Cannon\Stage\Texture\ nsmb.d\files\Stage\Texture\
mkdir nsmb.d\files\NewerRes
copy /b Cannon\NewerRes\ nsmb.d\files\NewerRes\
copy /b Cannon\Stage\ nsmb.d\files\Stage\

IF %GAMEID%==SMNP01 (
copy /b %MSGPATH%Cannon\MessageEN\ nsmb.d\files\EU\EngEU\Message\
copy /b %MSGPATH%Cannon\MessageEN\ nsmb.d\files\EU\FraEU\Message\
copy /b %MSGPATH%Cannon\MessageEN\ nsmb.d\files\EU\GerEU\Message\
copy /b %MSGPATH%Cannon\MessageEN\ nsmb.d\files\EU\ItaEU\Message\
copy /b %MSGPATH%Cannon\MessageEN\ nsmb.d\files\EU\SpaEU\Message\
copy /b Cannon\OpeningP\ nsmb.d\files\EU\Layout\openingTitle\
)
IF %GAMEID%==SMNE01 (
copy /b %MSGPATH%Cannon\MessageEN\ nsmb.d\files\US\EngUS\Message\
copy /b %MSGPATH%Cannon\MessageEN\ nsmb.d\files\US\FraUS\Message\
copy /b %MSGPATH%Cannon\MessageEN\ nsmb.d\files\US\SpaUS\Message\
copy /b Cannon\OpeningE\ nsmb.d\files\US\Layout\openingTitle\
)
IF %GAMEID%==SMNJ01 (
copy /b %MSGPATH%Cannon\MessageEN\ nsmb.d\files\JP\Message\
copy /b Cannon\OpeningJ\ nsmb.d\files\JP\Layout\openingTitle\
)

copy /b Cannon\Sound\Stream\ nsmb.d\files\Sound\stream\
copy /b Cannon\Layout\textures\ nsmb.d\files\Layout\textures\
copy /b Cannon\Layout\sequenceBG\ nsmb.d\files\Layout\sequenceBG\
copy /b Cannon\Layout\preGame\ nsmb.d\files\Layout\preGame\
copy /b Cannon\Layout\staffCredit\ nsmb.d\files\Layout\staffCredit\
copy /b Cannon\Sound\ nsmb.d\files\Sound\
copy /b Cannon\WorldMap\ nsmb.d\files\WorldMap\
copy /b Cannon\Env\ nsmb.d\files\Env\
copy /b Cannon\MovieDemo\ nsmb.d\files\MovieDemo\
copy /b Cannon\Object\ nsmb.d\files\Object\

IF %SLOTINPUT%==3 (
	SET SLOT=KMC
	copy /b SaveBanners\Cannon\%RG%\save_banner\ nsmb.d\files\%RG%\save_banner\
	)
SET XML=CannonP
SET PATCH=CS
IF %GAMEID%==SMNP01 SET GAMEID=SMNP04
IF %GAMEID%==SMNE01 SET GAMEID=SMNE04
IF %GAMEID%==SMNJ01 SET GAMEID=SMNJ04
SET MODNAME=Cannon SMBW

::Patch savegame-name here, since both Cannon and Summer Sun share same PATCH xml (CS.xml)
wit\wit dolpatch nsmb.d/sys/main.dol ^
802F148C=43616E6E6F6E4D#7769696D6A3264 ^
802F118C=43616E6E6F6E4D#7769696D6A3264 ^
802F0F8C=43616E6E6F6E4D#7769696D6A3264

GOTO PATCH

:BADVERAN
echo.
echo ISO version (%BASEVER%) not supported by Another, exiting...
rmdir nsmb.d /s /q
pause
exit

:ANOTHER
IF %GAMEID%==SMNJ01 GOTO BADVERAN 
IF %BASEVER%==EURv2 GOTO BADVERAN

IF %GAMEID%==SMNP01 (
copy /b %MSGPATH%Another\Lang\EUENGLISH.arc nsmb.d\files\EU\EngEU\Message\Message.arc
copy /b %MSGPATH%Another\Lang\EUFRENCH.arc nsmb.d\files\EU\FraEU\Message\Message.arc
copy /b %MSGPATH%Another\Lang\EUGERMAN.arc nsmb.d\files\EU\GerEU\Message\Message.arc
copy /b %MSGPATH%Another\Lang\EUITALIAN.arc nsmb.d\files\EU\ItaEU\Message\Message.arc
copy /b %MSGPATH%Another\Lang\EUSPANISH.arc nsmb.d\files\EU\SpaEU\Message\Message.arc
copy /b Another\Lang\staffroll.bin nsmb.d\files\EU\EngEU\staffroll\staffroll.bin
copy /b Another\Lang\staffroll.bin nsmb.d\files\EU\FraEU\staffroll\staffroll.bin
copy /b Another\Lang\staffroll.bin nsmb.d\files\EU\GerEU\staffroll\staffroll.bin
copy /b Another\Lang\staffroll.bin nsmb.d\files\EU\ItaEU\staffroll\staffroll.bin
copy /b Another\Lang\staffroll.bin nsmb.d\files\EU\SpaEU\staffroll\staffroll.bin
copy /b Another\Lang\mj2d00_PictureFont_32_RGBA8.brfnt nsmb.d\files\EU\EngEU\Font\mj2d00_PictureFont_32_RGBA8.brfnt
copy /b Another\Lang\mj2d00_PictureFont_32_RGBA8.brfnt nsmb.d\files\EU\FraEU\Font\mj2d00_PictureFont_32_RGBA8.brfnt
copy /b Another\Lang\mj2d00_PictureFont_32_RGBA8.brfnt nsmb.d\files\EU\GerEU\Font\mj2d00_PictureFont_32_RGBA8.brfnt
copy /b Another\Lang\mj2d00_PictureFont_32_RGBA8.brfnt nsmb.d\files\EU\ItaEU\Font\mj2d00_PictureFont_32_RGBA8.brfnt
copy /b Another\Lang\mj2d00_PictureFont_32_RGBA8.brfnt nsmb.d\files\EU\SpaEU\Font\mj2d00_PictureFont_32_RGBA8.brfnt
copy /b Another\Layout\OpeningP\ nsmb.d\files\EU\Layout\openingTitle\
)

IF %GAMEID%==SMNE01 (
copy /b %MSGPATH%Another\Lang\USENGLISH.arc nsmb.d\files\US\EngUS\Message\Message.arc
copy /b %MSGPATH%Another\Lang\USFRENCH.arc nsmb.d\files\US\FraUS\Message\Message.arc
copy /b %MSGPATH%Another\Lang\USSPANISH.arc nsmb.d\files\US\SpaUS\Message\Message.arc
copy /b Another\Lang\staffroll.bin nsmb.d\files\US\EngUS\staffroll\staffroll.bin
copy /b Another\Lang\staffroll.bin nsmb.d\files\US\FraUS\staffroll\staffroll.bin
copy /b Another\Lang\staffroll.bin nsmb.d\files\US\SpaUS\staffroll\staffroll.bin
copy /b Another\Lang\mj2d00_PictureFont_32_RGBA8.brfnt nsmb.d\files\US\EngUS\Font\mj2d00_PictureFont_32_RGBA8.brfnt
copy /b Another\Lang\mj2d00_PictureFont_32_RGBA8.brfnt nsmb.d\files\US\FraUS\Font\mj2d00_PictureFont_32_RGBA8.brfnt
copy /b Another\Lang\mj2d00_PictureFont_32_RGBA8.brfnt nsmb.d\files\US\SpaUS\Font\mj2d00_PictureFont_32_RGBA8.brfnt
copy /b Another\Layout\OpeningE\ nsmb.d\files\US\Layout\openingTitle\
)

copy /b Another\Lang\Other\01-01_N_1.bin nsmb.d\files\Replay\otehon\01-01_N_1.bin
copy /b Another\Lang\Other\01-02_N_1.bin nsmb.d\files\Replay\otehon\01-02_N_1.bin
copy /b Another\Lang\Other\01-04_N_1.bin nsmb.d\files\Replay\otehon\01-04_N_1.bin
copy /b Another\Lang\Other\01-06_N_1.bin nsmb.d\files\Replay\otehon\01-06_N_1.bin
copy /b Another\Stage\ nsmb.d\files\Stage\
copy /b Another\Sound\BGM_HIKOUSEN_ROUKA.32.brstm nsmb.d\files\Sound\stream\BGM_HIKOUSEN_ROUKA.32.brstm
copy /b Another\Sound\BGM_HIKOUSEN_ROUKA_FAST.32.brstm nsmb.d\files\Sound\stream\BGM_HIKOUSEN_ROUKA_FAST.32.brstm
copy /b Another\Sound\kazan_tika_fast_lr.ry.32.brstm nsmb.d\files\Sound\stream\kazan_tika_fast_lr.ry.32.brstm
copy /b Another\Sound\kazan_tika_lr.ry.32.brstm nsmb.d\files\Sound\stream\kazan_tika_lr.ry.32.brstm
copy /b Another\Sound\wii_mj2d_sound.brsar nsmb.d\files\Sound\wii_mj2d_sound.brsar
copy /b Another\Layout\controllerinformation.arc nsmb.d\files\Layout\controllerInformation\controllerInformation.arc
copy /b Another\Layout\MultiCorseSelectTexture.arc nsmb.d\files\Layout\textures\MultiCorseSelectTexture.arc
copy /b Another\Object\ nsmb.d\files\Object\
copy /b Another\WorldMap\ nsmb.d\files\WorldMap\
mkdir nsmb.d\files\AnotherRes
copy /b Another\AnotherRes\ nsmb.d\files\AnotherRes\
copy /b Another\Object\Background\ nsmb.d\files\Object\
copy /b Another\Stage\Texture\ nsmb.d\files\Stage\Texture\
mkdir nsmb.d\files\Sample
copy /b Another\Sample\tobira.bti nsmb.d\files\Sample\tobira.bti

IF %SLOTINPUT%==3 (
	SET SLOT=KMA
	copy /b SaveBanners\Another\%RG%\save_banner\ nsmb.d\files\%RG%\save_banner\
	)
SET XML=Another
SET PATCH=AN
IF %GAMEID%==SMNP01 SET GAMEID=SMNP05
IF %GAMEID%==SMNE01 SET GAMEID=SMNE05
SET MODNAME=Another SMBW

GOTO PATCH
 
:SUMMERSUN

copy /b SumSun\Stage\Texture\ nsmb.d\files\Stage\Texture\
mkdir nsmb.d\files\NewerRes
copy /b SumSun\NewerRes\ nsmb.d\files\NewerRes\
copy /b SumSun\Stage\ nsmb.d\files\Stage\
copy /b SumSun\Env\ nsmb.d\files\Env\

IF %GAMEID%==SMNP01 (
copy /b %MSGPATH%SumSun\EU\EngEU\Message\ nsmb.d\files\EU\EngEU\Message\
copy /b %MSGPATH%SumSun\EU\EngEU\Message\ nsmb.d\files\EU\FraEU\Message\
copy /b %MSGPATH%SumSun\EU\EngEU\Message\ nsmb.d\files\EU\GerEU\Message\
copy /b %MSGPATH%SumSun\EU\EngEU\Message\ nsmb.d\files\EU\ItaEU\Message\
copy /b %MSGPATH%SumSun\EU\EngEU\Message\ nsmb.d\files\EU\SpaEU\Message\
copy /b SumSun\EU\EngEU\staffroll\ nsmb.d\files\EU\EngEU\staffroll\
copy /b SumSun\EU\EngEU\staffroll\ nsmb.d\files\EU\FraEU\staffroll\
copy /b SumSun\EU\EngEU\staffroll\ nsmb.d\files\EU\GerEU\staffroll\
copy /b SumSun\EU\EngEU\staffroll\ nsmb.d\files\EU\ItaEU\staffroll\
copy /b SumSun\EU\EngEU\staffroll\ nsmb.d\files\EU\SpaEU\staffroll\
copy /b SumSun\OpeningP\ nsmb.d\files\EU\Layout\openingTitle\
)
IF %GAMEID%==SMNE01 (
copy /b %MSGPATH%SumSun\EU\EngEU\Message\ nsmb.d\files\US\EngUS\Message\
copy /b %MSGPATH%SumSun\EU\EngEU\Message\ nsmb.d\files\US\FraUS\Message\
copy /b %MSGPATH%SumSun\EU\EngEU\Message\ nsmb.d\files\US\SpaUS\Message\
copy /b SumSun\EU\EngEU\staffroll\ nsmb.d\files\US\EngUS\staffroll\
copy /b SumSun\EU\EngEU\staffroll\ nsmb.d\files\US\FraUS\staffroll\
copy /b SumSun\EU\EngEU\staffroll\ nsmb.d\files\US\SpaUS\staffroll\
copy /b SumSun\OpeningE\ nsmb.d\files\US\Layout\openingTitle\
)
IF %GAMEID%==SMNJ01 (
copy /b %MSGPATH%SumSun\EU\EngEU\Message\ nsmb.d\files\JP\Message\
copy /b SumSun\EU\EngEU\staffroll\ nsmb.d\files\JP\staffroll\
copy /b SumSun\OpeningJ\ nsmb.d\files\JP\Layout\openingTitle\
)

copy /b SumSun\Sound\stream\ nsmb.d\files\Sound\stream\
copy /b SumSun\Sound\ nsmb.d\files\Sound\
copy /b SumSun\WorldMap\ nsmb.d\files\WorldMap\
copy /b SumSun\Object\ nsmb.d\files\Object\
copy /b SumSun\Layout\preGame.arc nsmb.d\files\Layout\preGame\pregame.arc
copy /b SumSun\Layout\sequenceBG.arc nsmb.d\files\Layout\sequenceBG\sequenceBG.arc
copy /b SumSun\Layout\sequenceBGTexture.arc nsmb.d\files\Layout\textures\sequenceBGTexture.arc

IF %SLOTINPUT%==3 (
	SET SLOT=KMS
	copy /b SaveBanners\Summer\%RG%\save_banner\ nsmb.d\files\%RG%\save_banner\
	)
SET XML=SumSunP
SET PATCH=CS
IF %GAMEID%==SMNP01 SET GAMEID=SMNP06
IF %GAMEID%==SMNE01 SET GAMEID=SMNE06
IF %GAMEID%==SMNJ01 SET GAMEID=SMNJ06
SET MODNAME=Newer Summer Sun

wit\wit dolpatch nsmb.d/sys/main.dol ^
802F148C=53756D6D53756E#7769696D6A3264 ^
802F118C=53756D6D53756E#7769696D6A3264 ^
802F0F8C=53756D6D53756E#7769696D6A3264

GOTO PATCH

:HOLIDAY
copy /b XmasNewer\Stage\Texture\ nsmb.d\files\Stage\Texture\
copy /b XmasNewer\Stage\ nsmb.d\files\Stage\
copy /b XmasNewer\Env\ nsmb.d\files\Env\

IF %GAMEID%==SMNP01 (
copy /b %MSGPATH%XmasNewer\MessageEN\ nsmb.d\files\EU\EngEU\Message\
copy /b %MSGPATH%XmasNewer\MessageEN\ nsmb.d\files\EU\FraEU\Message\
copy /b %MSGPATH%XmasNewer\MessageEN\ nsmb.d\files\EU\GerEU\Message\
copy /b %MSGPATH%XmasNewer\MessageEN\ nsmb.d\files\EU\ItaEU\Message\
copy /b %MSGPATH%XmasNewer\MessageEN\ nsmb.d\files\EU\SpaEU\Message\
copy /b XmasNewer\OpeningP\ nsmb.d\files\EU\Layout\openingTitle\
)

IF %GAMEID%==SMNE01 (
copy /b %MSGPATH%XmasNewer\MessageEN\ nsmb.d\files\US\EngUS\Message\
copy /b %MSGPATH%XmasNewer\MessageEN\ nsmb.d\files\US\FraUS\Message\
copy /b %MSGPATH%XmasNewer\MessageEN\ nsmb.d\files\US\SpaUS\Message\
copy /b XmasNewer\OpeningE\ nsmb.d\files\US\Layout\openingTitle\
)

IF %GAMEID%==SMNJ01 (
copy /b %MSGPATH%XmasNewer\MessageEN\ nsmb.d\files\JP\Message\
copy /b XmasNewer\OpeningJ\ nsmb.d\files\JP\Layout\openingTitle\
)

copy /b XmasNewer\Sound\stream\ nsmb.d\files\Sound\stream\
copy /b XmasNewer\Layout\preGame\ nsmb.d\files\Layout\preGame\
copy /b XmasNewer\Layout\textures\ nsmb.d\files\Layout\textures\
copy /b XmasNewer\Sound\ nsmb.d\files\Sound\
copy /b XmasNewer\WorldMap\ nsmb.d\files\WorldMap\
copy /b XmasNewer\Object\ nsmb.d\files\Object\

IF %SLOTINPUT%==3 (
	SET SLOT=KMH
	copy /b SaveBanners\Holiday\%RG%\save_banner\ nsmb.d\files\%RG%\save_banner\
	)
IF %GAMEID%==SMNP01 (
	SET XML=XmasP
	SET GAMEID=SMNP07
	)
IF %GAMEID%==SMNE01 (
	SET XML=XmasE
	SET GAMEID=SMNE07
	)
IF %GAMEID%==SMNJ01 (
	SET XML=XmasJ
	SET GAMEID=SMNJ07
	)
SET PATCH=HS
SET MODNAME=Newer Holiday Special

GOTO PATCH

:ESBW
copy /b ESBW\Stage\Texture\ nsmb.d\files\Stage\Texture\
mkdir nsmb.d\files\NewerRes
copy /b ESBW\NewerRes\  nsmb.d\files\NewerRes\
copy /b ESBW\Stage\  nsmb.d\files\Stage\

IF %GAMEID%==SMNP01 (
copy /b ESBW\Font\ nsmb.d\files\EU\EngEU\Font\
copy /b ESBW\Font\ nsmb.d\files\EU\FraEU\Font\
copy /b ESBW\Font\ nsmb.d\files\EU\GerEU\Font\
copy /b ESBW\Font\ nsmb.d\files\EU\ItaEU\Font\
copy /b ESBW\Font\ nsmb.d\files\EU\SpaEU\Font\
copy /b %MSGPATH%ESBW\EU\EngEU\Message\ nsmb.d\files\EU\EngEU\Message\
copy /b %MSGPATH%ESBW\EU\EngEU\Message\ nsmb.d\files\EU\FraEU\Message\
copy /b %MSGPATH%ESBW\EU\EngEU\Message\ nsmb.d\files\EU\GerEU\Message\
copy /b %MSGPATH%ESBW\EU\EngEU\Message\ nsmb.d\files\EU\ItaEU\Message\
copy /b %MSGPATH%ESBW\EU\EngEU\Message\ nsmb.d\files\EU\SpaEU\Message\
copy /b ESBW\EU\EngEU\staffroll\ nsmb.d\files\EU\EngEU\staffroll\
copy /b ESBW\EU\EngEU\staffroll\ nsmb.d\files\EU\FraEU\staffroll\
copy /b ESBW\EU\EngEU\staffroll\ nsmb.d\files\EU\GerEU\staffroll\
copy /b ESBW\EU\EngEU\staffroll\ nsmb.d\files\EU\ItaEU\staffroll\
copy /b ESBW\EU\EngEU\staffroll\ nsmb.d\files\EU\SpaEU\staffroll\
copy /b ESBW\OpeningP\ nsmb.d\files\EU\Layout\openingTitle\
)

IF %GAMEID%==SMNE01 (
copy /b ESBW\Font\ nsmb.d\files\US\EngUS\Font\
copy /b ESBW\Font\ nsmb.d\files\US\FraUS\Font\
copy /b ESBW\Font\ nsmb.d\files\US\SpaUS\Font\
copy /b %MSGPATH%ESBW\EU\EngEU\Message\ nsmb.d\files\US\EngUS\Message\
copy /b %MSGPATH%ESBW\EU\EngEU\Message\ nsmb.d\files\US\FraUS\Message\
copy /b %MSGPATH%ESBW\EU\EngEU\Message\ nsmb.d\files\US\SpaUS\Message\
copy /b ESBW\EU\EngEU\staffroll\ nsmb.d\files\US\EngUS\staffroll\
copy /b ESBW\EU\EngEU\staffroll\ nsmb.d\files\US\FraUS\staffroll\
copy /b ESBW\EU\EngEU\staffroll\ nsmb.d\files\US\SpaUS\staffroll\
copy /b ESBW\OpeningE\ nsmb.d\files\US\Layout\openingTitle\
)

IF %GAMEID%==SMNJ01 (
copy /b ESBW\Font\ nsmb.d\files\JP\Font\
copy /b %MSGPATH%ESBW\EU\EngEU\Message\ nsmb.d\files\JP\Message\
copy /b ESBW\EU\EngEU\staffroll\ nsmb.d\files\JP\staffroll\
copy /b ESBW\OpeningJ\ nsmb.d\files\JP\Layout\openingTitle\
)

copy /b ESBW\Sound\stream\ nsmb.d\files\Sound\stream\
copy /b ESBW\Layout\textures\ nsmb.d\files\Layout\textures\
copy /b ESBW\Layout\sequenceBG\ nsmb.d\files\Layout\sequenceBG\
copy /b ESBW\Layout\preGame\ nsmb.d\files\Layout\pregame\
copy /b ESBW\Layout\staffCredit\ nsmb.d\files\Layout\staffCredit\
copy /b ESBW\Layout\continue\ nsmb.d\files\Layout\continue\
copy /b ESBW\Layout\corseSelectUIGuide\ nsmb.d\files\Layout\corseSelectUIGuide\
copy /b ESBW\Layout\dateFile\ nsmb.d\files\Layout\dateFile\
copy /b ESBW\Layout\gameScene\ nsmb.d\files\Layout\gameScene\
copy /b ESBW\Layout\miniGameCannon\ nsmb.d\files\Layout\miniGameCannon\
copy /b ESBW\Layout\miniGameWire\ nsmb.d\files\Layout\miniGameWire\
copy /b ESBW\Layout\MultiCourseSelect\ nsmb.d\files\Layout\MultiCourseSelect\
copy /b ESBW\Layout\pointResultDateFile\ nsmb.d\files\Layout\pointResultDateFile\
copy /b ESBW\Layout\pointResultDateFileFree\ nsmb.d\files\Layout\pointResultDateFileFree\
copy /b ESBW\Sound\ nsmb.d\files\Sound\
copy /b ESBW\WorldMap\ nsmb.d\files\WorldMap\
copy /b ESBW\Env\ nsmb.d\files\Env\
copy /b ESBW\MovieDemo\ nsmb.d\files\MovieDemo\
copy /b ESBW\Object\ nsmb.d\files\Object\

IF %SLOTINPUT==3 SET (
	SET SLOT=KME
	copy /b SaveBanners\Epic\%RG%\save_banner\ nsmb.d\files\%RG%\save_banner\
	)
SET XML=ESBWP
SET PATCH=EB
IF %GAMEID%==SMNP01 SET GAMEID=SMNP08
IF %GAMEID%==SMNE01 SET GAMEID=SMNE08
IF %GAMEID%==SMNJ01 SET GAMEID=SMNJ08
SET MODNAME=Epic Super Bowser World

GOTO PATCH

:RETRO
copy /b "Retro Remix\Layout\charaChangeSelectContents\" nsmb.d\files\Layout\charaChangeSelectContents\
copy /b "Retro Remix\Layout\continue\" nsmb.d\files\Layout\continue\
copy /b "Retro Remix\Layout\controllerInformation\" nsmb.d\files\Layout\controllerInformation\
copy /b "Retro Remix\Layout\corseSelectUIGuide\" nsmb.d\files\Layout\corseSelectUIGuide\
copy /b "Retro Remix\Layout\gameScene\" nsmb.d\files\Layout\gameScene\
copy /b "Retro Remix\Layout\miniGameCannon\" nsmb.d\files\Layout\miniGameCannon\
copy /b "Retro Remix\Layout\MultiCorseSelect\" nsmb.d\files\Layout\MultiCorseSelect\
copy /b "Retro Remix\Layout\pointResult\" nsmb.d\files\Layout\pointResult\
copy /b "Retro Remix\Layout\pointResultDateFile\" nsmb.d\files\Layout\pointResultDateFile\
copy /b "Retro Remix\Layout\pointResultDateFileFree\" nsmb.d\files\Layout\pointResultDateFileFree\
copy /b "Retro Remix\Layout\preGame\" nsmb.d\files\Layout\preGame\
copy /b "Retro Remix\MovieDemo\" nsmb.d\files\MovieDemo\
copy /b "Retro Remix\Object\" nsmb.d\files\Object\
copy /b "Retro Remix\Sound\" nsmb.d\files\Sound\
copy /b "Retro Remix\Sound\stream\" nsmb.d\files\Sound\stream\
copy /b "Retro Remix\Stage\" nsmb.d\files\Stage\
copy /b "Retro Remix\Stage\Texture\" nsmb.d\files\Stage\Texture\

IF %GAMEID%==SMNP01 (
copy /b "Retro Remix\US\EngUS\Message\" nsmb.d\files\EU\EngEU\Message\
copy /b "Retro Remix\US\EngUS\Message\" nsmb.d\files\EU\FraEU\Message\
copy /b "Retro Remix\US\EngUS\Message\" nsmb.d\files\EU\GerEU\Message\
copy /b "Retro Remix\US\EngUS\Message\" nsmb.d\files\EU\ItaEU\Message\
copy /b "Retro Remix\US\EngUS\Message\" nsmb.d\files\EU\SpaEU\Message\
copy /b "Retro Remix\US\Layout\OpeningTitle\" nsmb.d\files\EU\Layout\OpeningTitle\
copy /b "Retro Remix\US\save_banner\" nsmb.d\files\EU\save_banner\
)

IF %GAMEID%==SMNE01 (
copy /b "Retro Remix\US\EngUS\Message\" nsmb.d\files\US\EngUS\Message\
copy /b "Retro Remix\US\EngUS\Message\" nsmb.d\files\US\FraUS\Message\
copy /b "Retro Remix\US\EngUS\Message\" nsmb.d\files\US\SpaUS\Message\
copy /b "Retro Remix\US\Layout\OpeningTitle\" nsmb.d\files\US\Layout\OpeningTitle\
copy /b "Retro Remix\US\save_banner\" nsmb.d\files\US\save_banner\
)

IF %GAMEID%==SMNJ01 (
copy /b "Retro Remix\US\EngUS\Message\" nsmb.d\files\JP\Message\
copy /b "Retro Remix\US\EngUS\Message\" nsmb.d\files\JP\Message\
copy /b "Retro Remix\US\EngUS\Message\" nsmb.d\files\JP\Message\
copy /b "Retro Remix\US\Layout\OpeningTitle\" nsmb.d\files\JP\Layout\OpeningTitle\
copy /b "Retro Remix\US\save_banner\" nsmb.d\files\JP\save_banner\
)

copy /b "Retro Remix\WorldMap\" nsmb.d\files\WorldMap\

IF %GAMEID%==SMNP01 SET GAMEID=MRRP01
IF %GAMEID%==SMNE01 SET GAMEID=MRRE01
IF %GAMEID%==SMNJ01 SET GAMEID=MRRJ01
SET MODNAME=New Super Mario Bros. Wii Retro Remix

::only savegame and ap-kill patches for RR, no riivolution or loader.bin related stuff

wit\wit dolpatch nsmb.d/sys/main.dol ^
802F148C=526574726F524D#7769696D6A3264 ^
802F118C=526574726F524D#7769696D6A3264 ^
802F0F8C=526574726F524D#7769696D6A3264 ^
xml=../patch/AP.xml


GOTO REBUILD

:XMLMOD
for /f "tokens=* delims=" %%f in ('type riivolution\%XML%.xml') do CALL :DOREPLACE "%%f"

EXIT /b
:DOREPLACE
SET INPUT=%*
SET OUTPUT=%INPUT:80001800=803482C0%

for /f "tokens=* delims=" %%g in ('ECHO %OUTPUT%') do ECHO %%~g>>nsmb.d\%XML%-mod.xml
EXIT /b

:PATCH
:: patch main.dol before rebuilding
echo.
echo Applying %MOD% patches to main executable...

CALL :XMLMOD
wit\wit dolpatch nsmb.d/sys/main.dol ^
xml=../nsmb.d/!XML!-mod.xml -s ../%MODFOLDER%/ ^
xml=../patch/%PATCH%.xml ^
xml=../patch/AP.xml

:REBUILD
::Custom .bnr download, repository provided by AbdallahTerro
IF %BANNERDL%==1 (
	echo Downloading custom banner...
	wit\wget http://dl.dropboxusercontent.com/u/101209384/%GAMEID%.bnr -O banners/%GAMEID%.bnr
	)

::copy custom .bnr to game directory if available
echo Searching for and copying custom banner over original...

IF EXIST banners\%GAMEID%.bnr (
	echo Custom banner found.
	echo.
	echo Checking banner file for empty 0 byte file corruption made by wget 404 error...
	for %%x in ("banners\%GAMEID%.bnr") do IF %%~zx equ 0 (
		echo.
		echo Banner %GAMEID%.bnr is empty 0 byte file, deleting...
		echo Original game's banner will be used instead.
		del banners\%GAMEID%.bnr
		) ELSE (
		echo Does not seem to be an empty 0 byte file, continuing...
		copy /b banners\%GAMEID%.bnr nsmb.d\files\opening.bnr
		)
	) ELSE (
	echo Custom Banner not found, using original game's banner instead...
	)

IF %SLOTINPUT%==1 SET SLOT=S
IF %SLOTINPUT%==2 SET SLOT=K

IF %FILEEXT%==iso (
SET DESTPATH=../%MOD%_%GAMEID%_%BASEVER%_%SLOT%-sav.%FILEEXT%
)

IF %FILEEXT%==wbfs (
	mkdir "%MODNAME% [%GAMEID%]"
	SET DESTPATH=../%MODNAME% [%GAMEID%]/%GAMEID%.%FILEEXT%
	)

echo.
echo Rebuilding NSMBW Mod [%MODNAME%] as %FILEEXT%...
wit\wit copy nsmb.d "%DESTPATH%" -ovv --disc-id=%GAMEID% --tt-id=%SLOT% --name "%MODNAME%"

:: clean up working directory
echo.
echo Cleaning up working directory files...
rmdir nsmb.d /s /q

echo.
echo =========
echo All done^^!
echo =========
echo.

:: wait to make errors visible
pause