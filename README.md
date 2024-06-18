#################################################################

# powershell-scripts-repo

 Note that you may need to set your execution policy as follows 
 Set-ExecutionPolicy RemoteSigned

 or

 Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
 
 You will need to run you powershell terminal as administrator

 You will need to install PowerShellForGitHub

 From a PowerShell Terminal Enter:

 Import-Module PowerShellForGitHub

#################################################################

You can go here to learn more about execution policies for 7.4:

https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.4

#################################################################

For some of the scripts you will need to install GH CLI

https://github.com/cli/cli

For some of the scripts you will need to install GH-GEI

https://github.com/github/gh-gei

#################################################################

List of Scripts

#################################################################

1) Added PowerShell script to ftp to a server
   and pull files down to a local directory.
2) Add Powershell Script to Set Ollama Process
   to run as high priority using powershell.
3) Set Execution Policies.
4) Adding Sample OLLAMA LLM Scripts for command line
5) Added GH-GEI script to create a migration script for an organization.
   
   a) Needs a couple of Personal access tokens for each site (required)
   
   b) Needs a AZURE connection string for storage space (required)
   
7) Added GH-GEI script to migrate a single repository
   
   a) This script has the same requirements as #5

8) Added GH-CLI Repository Deletion Script

   a) You need a personal access token with delete privelages

9) Added GH-CLI Deletion Script that uses Env Variables

   a) Set up the Env Variables in System Settings

10) Added Set-Repo-Internal-Example.ps1

11) Added Set-Collab-GITHUB-Repository-Remotely-Example.ps1





   


   

   
   
