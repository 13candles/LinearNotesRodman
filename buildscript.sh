#!/bin/bash

echo "Note: This script will only run properly if executed from the main LinearNotesRodman folder"

read -p "Enter the name of the folder that will contain the HTML files and PDF that you want to create: " dirname

# go into the output folder
cd output || exit

# Create the directories
mkdir -p "$dirname-html"
mkdir -p "$dirname-latex"

# Navigate to the directory
cd "$dirname-html" || exit

echo "Copying SVG images and creating HTML output in directory: $(pwd)"
cp ../../source/images/*.svg . 
xsltproc -xinclude /home/sr/mathbook/xsl/pretext-html.xsl /mnt/c/Users/sward/Desktop/LinearNotesRodman/source/main.ptx

cd ..
cd "$dirname-latex" || exit
cp ../../source/images/*.pdf .

echo "Copying PDF images and creating LaTeX and PDF output in directory: $(pwd)"

xsltproc -xinclude -o LinearNotes.tex /home/sr/mathbook/xsl/pretext-latex.xsl /mnt/c/Users/sward/Desktop/LinearNotesRodman/source/main.ptx

pdflatex -interaction=batchmode LinearNotes.tex  #create the PDF from the .tex source

cd ../..
