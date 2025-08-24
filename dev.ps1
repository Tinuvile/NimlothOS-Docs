# LaTeX Development Mode Quick Start Script

param(
    [switch]$Full,      # Use full compilation mode (with bibliography)
    [switch]$Clean,     # Clean build files before starting
    [int]$Debounce = 2  # Debounce delay in seconds
)

Write-Host "LaTeX Development Mode Launcher" -ForegroundColor Magenta
Write-Host "===============================" -ForegroundColor Magenta

# Clean build files if requested
if ($Clean) {
    Write-Host "Cleaning build files..." -ForegroundColor Yellow
    . .\build.ps1 clean
    Write-Host ""
}

# Determine compilation mode
$compileMode = if ($Full) { "full" } else { "pdf" }

# Determine clean mode display
$cleanMode = if ($Clean) { "Yes" } else { "No" }

Write-Host "Startup Parameters:" -ForegroundColor Green
Write-Host "   Compile Mode: $compileMode"
Write-Host "   Debounce Delay: $Debounce seconds"
Write-Host "   Clean Mode: $cleanMode"
Write-Host ""

# Start monitoring
& .\watch.ps1 -Action $compileMode -Debounce $Debounce