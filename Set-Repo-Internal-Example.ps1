# Install-Module -Name PowerShellForGitHub -Scope CurrentUser
# Set execution policy for the current session
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned

# Import GitHub module
# Import-Module PowerShellForGitHub

# Your Personal Access Token from GitHub
#$token = 'your_personal_access_token'
$token = $env:GITHUB_PERSONAL_ACCESS_TOKEN

# Name of your organization on GitHub
$organizationName = 'utk-oit-apps-bis'

# Update repository visibility to 'internal'
function Set-RepoVisibilityInternal {
    $headers = @{
        Authorization = "token $token"
    }

    # Get all repos for the organization
    $uri = "https://api.github.com/orgs/$organizationName/repos?type=all&per_page=100"
    
    do {
        $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        
        foreach ($repo in $response) {
            # Skip if repository is already internal 
            if ($repo.private -ne $true -or $repo.visibility -eq "internal") {
                continue
            }

            # Set visibility to internal for each repository
            try {
                $updateUri = "$($repo.url)"
                Invoke-RestMethod -Uri $updateUri -Method Patch -Headers $headers -Body (@{visibility="internal"} | ConvertTo-Json)
                Write-Host ("Updated $($repo.name) to internal")
            }
            catch {
                Write-Error ("Failed to update $($repo.name): $_")
            }
        }

        # Check for pagination link header and update URI if present
        if ($response.Headers.'Link') {
            $matches = [regex]::Matches($response.Headers.'Link', '<([^>]+)>; rel="next"')
            
            if ($matches.Count -gt 0) {
                $uri = $matches.Groups[1].Value 
            } else {
                break 
            }
        } else {
            break 
        }
        
    } while ($true)
}

# Call the function to set repo visibility to internal
Set-RepoVisibilityInternal

