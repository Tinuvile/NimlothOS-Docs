# LaTeX Document Watch Script - Auto-compile on file changes

param(
    [string]$Action = "pdf",
    [int]$Debounce = 2  # Debounce delay in seconds
)

# Import build functions
. .\build.ps1

Write-Host "Starting LaTeX document watch mode..." -ForegroundColor Green
Write-Host "Watch directory: $(Get-Location)"
Write-Host "Compile mode: $Action"
Write-Host "Debounce delay: $Debounce seconds"
Write-Host "Press Ctrl+C to stop monitoring"
Write-Host ""

# Initial compilation
Write-Host "Performing initial compilation..." -ForegroundColor Yellow
switch ($Action.ToLower()) {
    "pdf" { Build-PDF }
    "full" { Build-Full }
    default { Build-PDF }
}

Write-Host "Started monitoring .tex file changes..." -ForegroundColor Green
Write-Host ""

# Simple polling approach - more reliable than events
$lastWriteTime = @{}

try {
    while ($true) {
        # Get all .tex files
        $texFiles = Get-ChildItem -Path . -Filter "*.tex" -Recurse | Where-Object { 
            $_.FullName -notmatch "\\build\\" 
        }
        
        $needsCompile = $false
        
        foreach ($file in $texFiles) {
            $currentWriteTime = $file.LastWriteTime
            
            if (-not $lastWriteTime.ContainsKey($file.FullName)) {
                # First time seeing this file
                $lastWriteTime[$file.FullName] = $currentWriteTime
            }
            elseif ($lastWriteTime[$file.FullName] -lt $currentWriteTime) {
                # File has been modified
                Write-Host "File changed: $($file.Name)" -ForegroundColor Cyan
                $lastWriteTime[$file.FullName] = $currentWriteTime
                $needsCompile = $true
            }
        }
        
        if ($needsCompile) {
            Write-Host "Waiting $Debounce seconds before compiling..." -ForegroundColor Gray
            Start-Sleep -Seconds $Debounce
            
            Write-Host ""
            Write-Host "File change detected, recompiling..." -ForegroundColor Yellow
            Write-Host "Time: $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Gray
            
            try {
                switch ($Action.ToLower()) {
                    "pdf" { Build-PDF }
                    "full" { Build-Full }
                    default { Build-PDF }
                }
                Write-Host "Compilation completed!" -ForegroundColor Green
            }
            catch {
                Write-Host "Compilation failed: $($_.Exception.Message)" -ForegroundColor Red
            }
            
            Write-Host "Continuing to monitor file changes..." -ForegroundColor Cyan
            Write-Host ""
        }
        
        # Check every second
        Start-Sleep -Seconds 1
    }
}
finally {
    Write-Host ""
    Write-Host "Monitoring stopped" -ForegroundColor Green
}