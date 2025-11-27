@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

title ODHUN Metin 2 Çözünürlük Değiştirici

:: Yönetici izni kontrolü
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] UYARI: Script yonetici yetkisiyle calismiyor.
    echo     Program Files icindeki dosyalara yazma izni olmayabilir.
    echo.
    pause
)

:: Metin2 dizinini otomatik bulma
set "configFile="
for %%d in (
    "C:\Program Files\Metin2\tr-TR\metin2.cfg"
    "C:\Program Files (x86)\Metin2\tr-TR\metin2.cfg"
    "%ProgramFiles%\Metin2\tr-TR\metin2.cfg"
    "%ProgramFiles(x86)%\Metin2\tr-TR\metin2.cfg"
) do (
    if exist %%~d (
        set "configFile=%%~d"
        goto found
    )
)

echo [!] metin2.cfg dosyasi bulunamadi.
echo     Oyunun kurulu oldugu dizini kontrol edin.
pause
goto :eof

:found
cls
echo ===============================
echo   Metin2 Çözünürlük Değiştirici
echo ===============================
echo [+] Config dosyasi bulundu: %configFile%
echo.

:menu
echo -------------------------------
echo   ODHUN Metin2 Çözünürlük Ayarlari
echo -------------------------------
echo 1) 800x600
echo 2) 1280x768
echo 3) 1600x1024
echo 4) 1920x1080
echo 5) Özel çözünürlük gir
echo -------------------------------
set /p choice="Seçiminiz (1-5): "

if "%choice%"=="1" (
    set width=800
    set height=600
) else if "%choice%"=="2" (
    set width=1280
    set height=768
) else if "%choice%"=="3" (
    set width=1600
    set height=1024
) else if "%choice%"=="4" (
    set width=1920
    set height=1080
) else if "%choice%"=="5" (
    set /p width="Genişlik (örn: 2560): "
    set /p height="Yükseklik (örn: 1440): "
) else (
    echo Geçersiz seçim. Tekrar deneyin.
    echo.
    goto menu
)

echo.
echo [+] %width%x%height% olarak ayarlanıyor...
pause

:: Dosyayı düzenleme
(
    for /f "usebackq delims=" %%i in ("%configFile%") do (
        set "line=%%i"
        if /i "!line:~0,5!"=="WIDTH" set "line=WIDTH    %width%"
        if /i "!line:~0,6!"=="HEIGHT" set "line=HEIGHT   %height%"
        echo !line!
    )
) > "%configFile%.tmp"

:: Değişiklikleri kaydetme
move /y "%configFile%.tmp" "%configFile%" >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Dosya yazilamadi. Yonetici yetkisi gerekiyor olabilir.
) else (
    cls
    echo ODHUN çözünürlüğünüzü sizin için değiştirdi.
    echo.
    for /l %%i in (3,-1,1) do (
        echo Kapanıyor: %%i...
        timeout /t 1 >nul
    )
    exit
)
