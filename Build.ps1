# PowerShell build script
$ErrorActionPreference = "Inquire"

# Get Windows version
$winver = cmd /c ver
$winver = $winver -split 'Version' -split ' ' -split ']'
$winver = $winver[5]

Write-Output "Windows version detected"
Write-Output "Using base image mcr.microsoft.com/windows/servercore:$winver"

# Download and extract Jellyfin
$url = "https://repo.jellyfin.org/releases/server/windows/stable/combined/jellyfin_10.8.8.zip"
Write-Output "Downloading $url"
Invoke-WebRequest -URI $url -OutFile ".\Jellyfin.zip"
Write-Output "Extracting archive"
Expand-Archive .\Jellyfin.zip .\

# Build image
Write-Output "Building Docker image..."
docker build --build-arg winver=$winver -t jellyfin-win .

Remove-Item .\jellyfin_* -Recurse
Remove-Item .\Jellyfin.zip

Write-Output "Build script finished."
Read-Host -Prompt "You can now create the container with docker run. Make sure to mount an existing or new config directory to C:\jellyfin\data"
