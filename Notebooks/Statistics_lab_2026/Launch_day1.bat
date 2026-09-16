@echo off
REM Windows one-click launcher: double-click this file to start the Day 1 tutorial.
cd /d "%~dp0"

REM Find the newest installed Rscript.exe
set "RSCRIPT="
for /d %%D in ("%ProgramFiles%\R\R-*") do set "RSCRIPT=%%D\bin\Rscript.exe"
if "%RSCRIPT%"=="" for /d %%D in ("%LocalAppData%\Programs\R\R-*") do set "RSCRIPT=%%D\bin\Rscript.exe"
if "%RSCRIPT%"=="" (
  where Rscript >nul 2>nul && set "RSCRIPT=Rscript"
)
if "%RSCRIPT%"=="" (
  echo R was not found. Install R from https://cran.r-project.org and try again.
  pause
  exit /b 1
)

REM Pandoc ships inside RStudio; tell R where it is when running outside RStudio
if "%RSTUDIO_PANDOC%"=="" (
  if exist "%ProgramFiles%\RStudio\resources\app\bin\quarto\bin\tools\pandoc.exe" set "RSTUDIO_PANDOC=%ProgramFiles%\RStudio\resources\app\bin\quarto\bin\tools"
  if exist "%ProgramFiles%\RStudio\resources\app\bin\quarto\bin\tools\x86_64\pandoc.exe" set "RSTUDIO_PANDOC=%ProgramFiles%\RStudio\resources\app\bin\quarto\bin\tools\x86_64"
  if exist "%ProgramFiles%\RStudio\bin\quarto\bin\tools\pandoc.exe" set "RSTUDIO_PANDOC=%ProgramFiles%\RStudio\bin\quarto\bin\tools"
  if exist "%ProgramFiles%\RStudio\bin\pandoc\pandoc.exe" set "RSTUDIO_PANDOC=%ProgramFiles%\RStudio\bin\pandoc"
)

echo Starting the Day 1 tutorial. A browser tab will open; keep this window open while you work.
echo To stop: close this window or press Ctrl+C.
"%RSCRIPT%" -e "source('setup.R'); rmarkdown::run('day1.Rmd', shiny_args = list(launch.browser = TRUE))"
echo The tutorial has stopped.
pause
