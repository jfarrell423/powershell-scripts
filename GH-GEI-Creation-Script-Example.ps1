#GH-GEI Structure to Create a Migration Script
#This command will create a Migration Scripts to move a whole organization.
#GH CLI is required and GH-GEI from GITHUB

#Author Jerry Farrell
#Team   UTK OIT Apps

# Source Location Environment Variables Session Specific
$env:GH_SOURCE_PAT       = "<Source Personal Access Token>"
$env:GH_ENTERPRISE_TOKEN = "<Source Personal Access Token>"

$env:GH_PAT              = "<Target Personal Access Token>"
$env:GH_HOST             = "Original Host Server URL"

The scripts require Azure Storage to Migrate from Enterprise to github.com
$env:AZURE_STORAGE_CONNECTION_STRING = "<Connection String for Azure Storage>"

# Exporting is not needed in PowerShell as setting them is enough for accessing throughout the current session.

gh gei generate-script --github-source-org <Source Organization> --github-target-org <Target Organization> --output <Name of Script File to be created .ps1 extension> --ghes-api-url https://github.utk.edu/api/v3