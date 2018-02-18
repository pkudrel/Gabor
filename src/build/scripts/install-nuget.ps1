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

function createDirIfnotExists($path) {
    if (!(test-path $path)) {
        New-Item -ItemType Directory -Force -Path $path | Out-Null
    }

}


Push-Location
try {
	
    "Install Nuget"
    "Script dir: $PSScriptRoot"
    Set-Location $PSScriptRoot
    $rootPath = exec { git rev-parse --show-toplevel } "Get-GitRepoRoot: Problem with git"
    "Root dir: $rootPath"
    $toolsPath = Join-Path $rootPath "src/build/tools"
    "Tools dir: $toolsPath"
    createDirIfnotExists $toolsPath

    $nugetDir = Join-Path $toolsPath "nuget"
    createDirIfnotExists $nugetDir

    $nuget = Join-Path $nugetDir "nuget.exe"
    Set-Location $nugetDir 
	
    if (!(test-path $nuget)) {
        Invoke-WebRequest https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile $nuget
    }
    else {

        exec {& $nuget update -self}
    }
	
	

}

catch {
    Write-Error "Error: $_"
    BREAK
}
finally {
    Pop-Location
}