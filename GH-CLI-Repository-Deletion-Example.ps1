########################################################################################################
# GITHUB Repository Deletion Script
# Set your GitHub username, the repository name to be deleted, and your personal access token
# User Name can be an Organization name provided it is used by PAT that has access to the organization.
########################################################################################################
$githubUsername = "YOUR_USERNAME"
$repositoryName = "REPO_NAME"
$personalAccessToken = "YOUR_PERSONAL_ACCESS_TOKEN"
########################################################################################################
# Define the GitHub API URL for deleting a repository
$apiUrl = "https://api.github.com/repos/$githubUsername/$repositoryName"
########################################################################################################
# Use Base64 encoding for the authorization header
$headers = @{
    Authorization = "token $personalAccessToken"
}
########################################################################################################
try {
    # Invoke the REST method DELETE on the API URL with headers for authentication
    Invoke-RestMethod -Uri $apiUrl -Method Delete -Headers $headers

    Write-Host "Repository '$repositoryName' has been successfully deleted."
} catch {
    # Catch and display any errors
    Write-Error $_.Exception.Message
}
########################################################################################################
