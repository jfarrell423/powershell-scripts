# Environment variables for GitHub username and PAT
$githubUser = [System.Environment]::GetEnvironmentVariable('GITHUB_USERNAME')
#
$githubToken = [System.Environment]::GetEnvironmentVariable('GITHUB_PERSONAL_ACCESS_TOKEN')

# Using Environment Variable
#$newCollaboratorUsername = [System.Environment]::GetEnvironmentVariable('NEW_COLLABORATOR_USERNAME')
# Hard Coding User Name
$newCollaboratorUsername = "(GITHUB User Name)"
# Base URL for GitHub API
$apiUrlBase = 'https://api.github.com'

# Headers for authentication
$headers = @{
    Authorization = "token $githubToken"
    Accept = 'application/vnd.github.v3+json'
}

function List-Repositories {
    param (
        [string]$user
    )
    # List all repositories for the user
    $reposUrl = "$apiUrlBase/users/$user/repos"
    
    try {
        $response = Invoke-RestMethod -Uri $reposUrl -Method Get -Headers $headers
        return $response
    }
    catch {
        throw $_.Exception.Message
    }
}

function Add-CollaboratorToRepo {
    param (
        [string]$repoName,
        [string]$collaboratorUsername
    )

    # Add a collaborator to a specific repository
    $collaboratorsUrl = "$apiUrlBase/repos/$githubUser/$repoName/collaborators/$collaboratorUsername"
    
    try {
        # Use PUT method to add a collaborator, ignore the response body with Out-Null
        Invoke-RestMethod -Uri $collaboratorsUrl -Method Put -Headers $headers | Out-Null
        
        Write-Host "Successfully added $collaboratorUsername to $repoName"
        
        return $true;
        
    } catch {
        
        Write-Host "Failed to add $collaboratorUsername to $repoName. Status code: $_.Exception.Response.StatusCode.Value__"

        return $false;
        
  }
}

try {
    
   # List all repositories and add new collaborator to each one.
   List-Repositories -user $githubUser | ForEach-Object {

       Add-CollaboratorToRepo -repoName $_.name -collaboratorUsername 	$newCollaboratorUsername

   }

   Write-Host "All done!"

} catch {

   Write-Host "An error occurred: $_"

}

#end of script