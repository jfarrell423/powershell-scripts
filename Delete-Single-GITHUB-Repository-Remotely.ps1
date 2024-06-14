#############################################################################
# PowerShell GITHUB Deletion Script Using Environment Variables
# This is safer than hard coding the Personal Access Token into the script
#
# Usage:
# .\Delete-Single-GITHUB-Repository.ps1 -repositoryName "REPO_NAME"
#
# This is using the GITHUB Rest API for server access.
#############################################################################
param (
    [Parameter(Mandatory=$true)]
    [string]$repositoryName
)

# Fetch the GitHub username and personal access token from environment variables
# This Environment Variable can be a user name or organization name
$githubUsername = $env:GITHUB_USERNAME
# This personal access token has to be given delete privs
$personalAccessToken = $env:GITHUB_PERSONAL_ACCESS_TOKEN

if (-not $githubUsername -or -not $personalAccessToken) {
    Write-Error "Please ensure GITHUB_USERNAME and GITHUB_PERSONAL_ACCESS_TOKEN environment variables are set."
    exit 1
}

# Define the GitHub API URL for deleting a repository
$apiUrl = "https://api.github.com/repos/$githubUsername/$repositoryName"

# Use token for the authorization header
$headers = @{
    Authorization = "token $personalAccessToken"
}

try {
    # Invoke the REST method DELETE on the API URL with headers for authentication
    Invoke-RestMethod -Uri $apiUrl -Method Delete -Headers $headers

    Write-Host "Repository '$repositoryName' has been successfully deleted."
} catch {
    # Catch and display any errors
    Write-Error $_.Exception.Message
}

