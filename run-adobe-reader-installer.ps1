# Set execution policy (if needed)
Set-ExecutionPolicy RemoteSigned -Scope Process -Force

# Run the script from GitHub
Invoke-Expression (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/firewelltech/adobe-reader/main/install-adobe-reader.ps1?token=GHSAT0AAAAAACOAWBQJ4QAGPNO775SNBXLUZOXQQSA').Content
