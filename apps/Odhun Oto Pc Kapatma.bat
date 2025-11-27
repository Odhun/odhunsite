@echo off
title Odhun Bilgisayar Kapatma Yonetimi
color 0a
setlocal enabledelayedexpansion

:menu
cls
echo ==============================
echo     Odhun Bilgisayar Kapatma Menusu
echo ==============================
echo.
echo 1 - Zamanli kapatma ayarla (dk)
echo 2 - Belirli saatte kapatma ayarla
echo 3 - Kapatma islemini iptal et
echo 0 - Cikis
echo.
set /p secim="Seciminizi giriniz: "

if "%secim%"=="1" goto zamanli
if "%secim%"=="2" goto saatli
if "%secim%"=="3" goto iptal
if "%secim%"=="0" exit
goto menu

:zamanli
cls
echo ==============================
echo     Zamanli Kapatma Ayarlama
echo ==============================
set /p dk="Kac dakika sonra kapatilsin?: "
set /a sn=%dk%*60
shutdown -s -f -t %sn%
echo.
echo Bilgisayar %dk% dakika (%sn% saniye) sonra kapatilacak.
pause
goto menu

:saatli
cls
echo ==============================
echo     Belirli Saatte Kapatma
echo ==============================
echo Ornek: 23:30 gibi giriniz.
set /p hedef_saat="Saat giriniz (HH:MM): "

for /f "tokens=1,2 delims=:" %%a in ("%time:~0,5%") do (
    set simdi_saat=%%a
    set simdi_dakika=%%b
)

for /f "tokens=1,2 delims=:" %%a in ("%hedef_saat%") do (
    set hedef_saat_saat=%%a
    set hedef_saat_dakika=%%b
)

:: Mevcut zamanı dakika cinsine çevir
set /a simdi_toplam=!simdi_saat! * 60 + !simdi_dakika!

:: Hedef zamanı dakika cinsine çevir
set /a hedef_toplam=!hedef_saat_saat! * 60 + !hedef_saat_dakika!

:: Farkı bul (saniyeye çevir)
set /a fark_dk=hedef_toplam - simdi_toplam
if !fark_dk! lss 0 set /a fark_dk+=1440
set /a sn=!fark_dk!*60

shutdown -s -f -t !sn!
echo.
echo Bilgisayar %hedef_saat% saatinde kapatilacak. (!sn! saniye sonra)
pause
goto menu

:iptal
cls
echo ==============================
echo   Kapatma Islemini Iptal Etme
echo ==============================
shutdown -a
echo.
echo Kapatma islemi iptal edildi!
pause
goto menu
