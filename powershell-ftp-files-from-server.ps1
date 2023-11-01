$logDate = Get-Date
$folderDate = Get-Date -Format "yyyy-MM-dd"
$targetServer = "dns name of target server where files reside"
$targetPath = "full path where files are pulled from"
$destPath = "local windows path to place the files"
$log = "$destPath\Transfer_Logs\$folderDate.log"
$userName = "login id"
$password = "login password"
$encryptedPass = ConvertTo-SecureString -String $password -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential($userName, $encryptedPass)
$logMsg = @()

try {
	Install-Module -Name Posh-SSH -RequiredVersion 2.0.2 -ErrorAction stop
} catch {
	"ERROR: " + $Error[0].CategoryInfo.Activity + ": " + $Error[0].Exception.Message | Out-File $log -Append
}

"*********************************************" | Out-File $log
"            $logDate                         " | Out-File $log -Append
"*********************************************" | Out-File $log -Append
"" | Out-File $log -Append

try {
	$sftpSession = New-SFTPSession -ComputerName $targetServer -Credential $creds -Port 22 -Force -ErrorAction Stop
	$sftpPath = Set-SFTPLocation -SFTPSession $sftpSession -Path $targetPath -ErrorAction stop
	$sftpFiles = Get-SFTPChildItem -SFTPSession $sftpSession -Path $sftpPath -ErrorAction Stop | ? { $_.FullName -like "*.xml" }
} catch {
	"$errormessage = ERROR: " + $Error[0].CategoryInfo.Activity + ": " + $Error[0].Exception.Message | Send-MailMessage -To oit_sunapsisss@utk.edu -From sunapsis@utk.edu -Subject "ERROR: Sunapsis Download Failed" -Body "$errormessage has occurred - the script probably failed to download files" -SmtpServer smtp.utk.edu
}

foreach ($sftpFile in $sftpFiles) {
	try {
		Get-SFTPFile -SFTPSession $sftpSession -RemoteFile $sftpFile.Name -LocalPath $destPath -Overwrite -ErrorAction Stop
		Remove-SFTPItem -SFTPSession $sftpSession -Path $sftpFile.FullName -Force -ErrorAction Stop
		$logMsg += "SUCCESS: $($sftpFile.Name) copied and removed from bangateway.sis.utk.edu to $destPath"
	} catch {
		$logMsg += "ERROR: " + $Error[0].CategoryInfo.Activity + ": " + $Error[0].Exception.Message
	}
}

$successCount = ($logMsg | ? { $_ -match "SUCCESS" }).Count
$errorCount = ($logMsg | ? { $_ -match "ERROR" }).Count

$logMsg | Out-File $log -Append
"----------------------------------" | Out-File $log -Append
"$successCount Files copied and removed successfully" | Out-File $log -Append
"$errorCount Files did not copy from source." | Out-File $log -Append
"----------------------------------" | Out-File $log -Append
"" | Out-File $log -Append