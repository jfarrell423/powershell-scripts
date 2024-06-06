# Get all processes named 'ollama'
# Next set priority to high
<# 

This script tries to get all instances of 'ollama' processes and 
then loops through them to set their priority class to High. 
If no 'ollama' applications are found or there's an error (like lack of permissions), 
it will provide feedback accordingly. Before you run this script, 
please be aware that setting application priorities can affect system stability and 
performance. It's a good practice to test scripts like this in a controlled environment 
before running them on a production system. 

#>
$ollamaProcesses = Get-Process ollama -ErrorAction SilentlyContinue

if ($ollamaProcesses) {
    foreach ($process in $ollamaProcesses) {
        try {
            # Set the priority of each process to 'High'
            $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
            Write-Host "Successfully set priority for $($process.Id)"
        } catch {
            Write-Error "Failed to set priority for $($process.Id): $_"
        }
    }
} else {
    Write-Host "No 'ollama' applications found or already running at high priority."
}