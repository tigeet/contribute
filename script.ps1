$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$repositoryPath = $PSScriptRoot
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

    $updateMessage = @'
# Contribute
## Usage
``win + r`` $\to$ ``taskschd.msc``  
Создать простую задачу 
Триггер - ``При запуске компьютера``  
Выберите действие для задачи - ``Запустить программу``  
Программа или сценарий - ``powershell``  
Добавить аргументы - ``-File <dir>/script.ps1``  
## Last update: ``{0}``
'@ -f $todayDate

    $commitMessage = "Automated daily commit: $todayDate"
    
    if (Test-Path $readmePath) {
        Set-Content -Path $readmePath -Value $updateMessage
    } else {
        Set-Content -Path $readmePath -Value $updateMessage
    }

    git add .
    git commit -m $commitMessage
    git push origin $branchName

}
