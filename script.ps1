$repositoryPath = "."
$branchName = "main"
$logFile = "./contribute.log"
$readmePath = './README.md'
if (Test-Path $logFile) {
    $lastRunDate = Get-Content $logFile
} else {
    $lastRunDate = "Never"
}


$todayDate = (Get-Date).ToString("yyyy-MM-dd")


if ($lastRunDate -ne $todayDate) {
    Set-Location $repositoryPath
    $todayDate | Out-File $logFile

    $updateMessage = "`nLast update: $todayDate`n"
    $commitMessage = "Automated daily commit: $todayDate"
    
    if (Test-Path $readmePath) {
        Add-Content -Path $readmePath -Value $updateMessage
    } else {
        Set-Content -Path $readmePath -Value $updateMessage
    }

    git add .
    git commit -m $commitMessage
    git push origin $branchName

}
