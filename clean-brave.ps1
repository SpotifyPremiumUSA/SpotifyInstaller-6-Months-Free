# Ensure Brave is closed
Stop-Process -Name "brave" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Path to Brave user data (Default profile)
$braveDataPath = "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default"

# List of files to remove for history, autofill, and login data
$targets = @(
    "History",
    "Web Data",
    "Login Data",
    "Login Data-journal",
    "Web Data-journal",
    "History-journal"
)

# Delete target files
foreach ($file in $targets) {
    $fullPath = Join-Path -Path $braveDataPath -ChildPath $file
    if (Test-Path $fullPath) {
        try {
            Remove-Item $fullPath -Force -ErrorAction Stop
        } catch {
            Write-Output "Failed to delete: $fullPath"
        }
    }
}

# Optional: suppress any output
$host.UI.RawUI.WindowTitle = ''
Clear-Host
