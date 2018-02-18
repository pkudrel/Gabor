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
    "Install Tools"
    exec {& "$PSScriptRoot\install-invokebuild.ps1"}
    exec {& "$PSScriptRoot\install-nuget.ps1"}
}

catch {
    Write-Error "Error: $_"
    BREAK
}
finally {
    Pop-Location
}