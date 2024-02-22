# determining the latest version of Reader
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.67 Safari/537.36"

try {
    $result = Invoke-RestMethod -Uri "https://rdc.adobe.io/reader/products?lang=mui&site=enterprise&os=Windows%2011&country=US&nativeOs=Windows%2010&api_key=dc-get-adobereader-cdn" `
        -WebSession $session `
        -Headers @{
            "Accept"="*/*"
            "Accept-Encoding"="gzip, deflate, br"
            # ... (other headers)
            "x-api-key"="dc-get-adobereader-cdn"
        }
    
    $version = $result.products.reader[0].version
    $version = $version -replace '\.'
    
    # downloading
    $URI = "https://ardownload2.adobe.com/pub/adobe/acrobat/win/AcrobatDC/$Version/AcroRdrDCx64$($Version)_MUI.exe"
    $OutFile = Join-Path $env:TEMP "AcroRdrDCx64$($version)_MUI.exe"
    
    Write-Host "Downloading version $version from $URI to $OutFile"
    Invoke-WebRequest -Uri $URI -OutFile $OutFile -Verbose
    
    # silent install
    Start-Process -FilePath $OutFile -ArgumentList "/sAll /rs /rps /msi /norestart /quiet EULA_ACCEPT=YES" -WorkingDirectory $env:TEMP -Wait -LoadUserProfile
    
    # cleanup
    Remove-Item $OutFile -ErrorAction SilentlyContinue
    
    Write-Host "Normal completion"
} catch {
    Write-Host "Error: $_"
}