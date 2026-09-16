#!/bin/bash
# Instructor tool: rebuild the student download Notebooks/Statistics_lab_2026.zip
# (only the files needed to run the Day 1 tutorial). Run after changing day1.Rmd,
# helpers.R, setup.R, the launchers or the data. Usage, from anywhere:
#   bash Notebooks/Statistics_lab_2026/scripts/build_zip.sh
set -e
cd "$(dirname "$0")/../.."          # Notebooks/
rm -f Statistics_lab_2026.zip
zip -r -X Statistics_lab_2026.zip \
  Statistics_lab_2026/Statistics_lab.Rproj \
  Statistics_lab_2026/.Rprofile \
  Statistics_lab_2026/day1.Rmd \
  Statistics_lab_2026/helpers.R \
  Statistics_lab_2026/setup.R \
  Statistics_lab_2026/Launch_day1.command \
  Statistics_lab_2026/Launch_day1.bat \
  Statistics_lab_2026/README.md \
  Statistics_lab_2026/data/README.md \
  Statistics_lab_2026/data/mmse_small.csv \
  Statistics_lab_2026/data/neurites.csv
unzip -l Statistics_lab_2026.zip
