# Set Environment Variables for current session
# This script will pull Enterprise Source Code to GITHUB.COM
# You can set the following values as windows environment variables.
# That method will keep your scripts more secure.

$env:GH_SOURCE_PAT       = "<Source Personal Access Token>"
$env:GH_PAT              = "<Target Personal Access Token>"
$env:GH_HOST             = "Original Host Server URL"
$env:GH_ENTERPRISE_TOKEN = "<Source Personal Access Token>"
$env:AZURE_STORAGE_CONNECTION_STRING = "<Connection String for Azure Storage>"

# Exporting is not needed in PowerShell as setting them is enough for accessing throughout the current session.
# Final working script
gh gei migrate-repo --ghes-api-url https://github.utk.edu/api/v3 --github-source-org <Source Organization> --source-repo <Source Repo> --github-target-org <Traget Organization> --target-repo <Target Repo>
