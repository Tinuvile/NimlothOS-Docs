# LaTeX Document Build Script

param(
    [string]$Action = "pdf"
)

# Main document name
$MAIN = "main"

# LaTeX compiler
$LATEX = "xelatex"

# BibTeX compiler
$BIBTEX = "bibtex"

# Output directory
$OUTDIR = "build"

function Create-OutputDir {
    if (!(Test-Path $OUTDIR)) {
        New-Item -ItemType Directory -Path $OUTDIR | Out-Null
        Write-Host "Created output directory: $OUTDIR"
    }
}

function Build-PDF {
    Create-OutputDir
    Write-Host "Building PDF document..."
    & $LATEX -shell-escape -output-directory=$OUTDIR "$MAIN.tex"
    & $LATEX -shell-escape -output-directory=$OUTDIR "$MAIN.tex"
    Write-Host "PDF build completed: $OUTDIR\$MAIN.pdf"
}

function Build-Full {
    Create-OutputDir
    Write-Host "Full build with bibliography..."
    & $LATEX -shell-escape -output-directory=$OUTDIR "$MAIN.tex"
    & $BIBTEX "$OUTDIR\$MAIN"
    & $LATEX -shell-escape -output-directory=$OUTDIR "$MAIN.tex"
    & $LATEX -shell-escape -output-directory=$OUTDIR "$MAIN.tex"
    Write-Host "Full build completed: $OUTDIR\$MAIN.pdf"
}

function Clean-Files {
    if (Test-Path $OUTDIR) {
        Remove-Item -Recurse -Force $OUTDIR
        Write-Host "Cleanup completed"
    }
}

function View-PDF {
    Build-PDF
    if (Test-Path "$OUTDIR\$MAIN.pdf") {
        Start-Process "$OUTDIR\$MAIN.pdf"
    } else {
        Write-Host "PDF file does not exist"
    }
}

switch ($Action.ToLower()) {
    "pdf" { Build-PDF }
    "full" { Build-Full }
    "clean" { Clean-Files }
    "view" { View-PDF }
    default {
        Write-Host "Usage: .\build.ps1 [pdf|full|clean|view]"
        Write-Host "  pdf   - Basic compilation"
        Write-Host "  full  - Full compilation with bibliography"
        Write-Host "  clean - Clean temporary files"
        Write-Host "  view  - Build and view PDF"
    }
}