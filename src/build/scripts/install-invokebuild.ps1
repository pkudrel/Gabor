#Borrowed from psake
function exec {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)][scriptblock]$Command,
        [Parameter(Mandatory = $false, Position = 1)][string]$ErrorMessage = ("Failed executing {0}" -F $Command)
    )

    & $Command
    if ($LASTEXITCODE -ne 0) {
        throw ("Exec: " + $ErrorMessage)
    }
}


Push-Location
try {
    "Install Invoke-Build"
    "Script dir: $PSScriptRoot"
    Set-Location $PSScriptRoot
    $rootPath = exec { git rev-parse --show-toplevel } "Get-GitRepoRoot: Problem with git"
    "Root dir: $rootPath"
    $toolsPath = Join-Path $rootPath "src/build/tools"

    "Tools dir: $toolsPath"
    if (!(test-path $toolsPath)) {
        New-Item -ItemType Directory -Force -Path $toolsPath | Out-Null
    }
    Set-Location $toolsPath
    Invoke-Expression "& {$((New-Object Net.WebClient).DownloadString('https://github.com/nightroman/PowerShelf/raw/master/Save-NuGetTool.ps1'))} Invoke-Build"
}

catch {
}
finally {
    Pop-Location
}