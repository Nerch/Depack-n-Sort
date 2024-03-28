@echo off
setlocal enabledelayedexpansion

:: Nutzt das Verzeichnis, in dem das Skript gespeichert ist
set "sourceDir=%~dp0"

cd /d %sourceDir%

:: Sicherheitsabfrage vor dem Fortfahren
echo Sind Sie sicher, dass Sie alle Archive in %sourceDir% entpacken und anschliessend löschen möchten? (J/N)
choice /C JN /M "Ihre Wahl:"
if errorlevel 2 goto end

:: Entpackt jede Archivdatei im aktuellen Verzeichnis und löscht die Archivdatei anschließend
for %%f in (*.zip *.rar) do (
    echo Entpacke: %%f
    "C:\Program Files\7-Zip\7z.exe" x "%%f" -y
    if !errorlevel! equ 0 (
        echo Lösche: %%f
        del "%%f"
        echo Warte 1 Sekunden bevor die nächste Datei bearbeitet wird...
        timeout /t 1 /nobreak
    ) else (
        echo Fehler beim Entpacken von: %%f
    )
)

echo Fertig! Alle Archive wurden entpackt und die Archivdateien gelöscht.
pause
goto end

:end
echo Vorgang abgebrochen.
pause
