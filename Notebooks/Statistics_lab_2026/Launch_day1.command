#!/bin/bash
# macOS one-click launcher: double-click this file to start the Day 1 tutorial.
# (If macOS refuses to open it, right-click > Open once, or run: chmod +x Launch_day1.command)
cd "$(dirname "$0")" || exit 1

# Find Rscript
RSCRIPT="$(command -v Rscript)"
[ -z "$RSCRIPT" ] && [ -x /usr/local/bin/Rscript ] && RSCRIPT=/usr/local/bin/Rscript
[ -z "$RSCRIPT" ] && [ -x /opt/homebrew/bin/Rscript ] && RSCRIPT=/opt/homebrew/bin/Rscript
[ -z "$RSCRIPT" ] && [ -x /Library/Frameworks/R.framework/Resources/bin/Rscript ] && RSCRIPT=/Library/Frameworks/R.framework/Resources/bin/Rscript
if [ -z "$RSCRIPT" ]; then
  echo "R was not found. Install R from https://cran.r-project.org and try again."
  read -r -p "Press Enter to close."; exit 1
fi

# Pandoc ships inside RStudio; tell R where it is when running outside RStudio
if [ -z "$RSTUDIO_PANDOC" ]; then
  for d in /Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/aarch64 \
           /Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/x86_64 \
           /Applications/RStudio.app/Contents/Resources/app/bin/quarto/bin/tools \
           /Applications/RStudio.app/Contents/Resources/app/bin/pandoc; do
    [ -x "$d/pandoc" ] && export RSTUDIO_PANDOC="$d" && break
  done
fi

echo "Starting the Day 1 tutorial. A browser tab will open; keep this window open while you work."
echo "To stop: close this window or press Ctrl+C."
"$RSCRIPT" -e 'source("setup.R"); rmarkdown::run("day1.Rmd", shiny_args = list(launch.browser = TRUE))'
read -r -p "The tutorial has stopped. Press Enter to close."
