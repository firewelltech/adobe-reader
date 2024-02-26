# Set a temporary folder
$tempFolder = [System.IO.Path]::GetTempPath()
$scriptUrl = 'https://raw.githubusercontent.com/firewelltech/adobe-reader/main/install-adobe-reader.ps1'
$scriptPath = Join-Path $tempFolder 'install-adobe-reader.ps1'

# Download the script to the temporary folder
Invoke-WebRequest -Uri $scriptUrl -OutFile $scriptPath

# Execute the downloaded script
Invoke-Expression $scriptPath

# Delete the downloaded script
Remove-Item $scriptPath
