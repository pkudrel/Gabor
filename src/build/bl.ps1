#requires -Version 3.0
<#
.Synopsis
	Build luncher for (https://github.com/nightroman/Invoke-Build)
	This script create spacial variable $BL
#>

param(
	$scriptFile = (Join-Path $PSScriptRoot ".build.ps1"),
	$major = 0,
	$minor = 0,
	$patch = 0,
	$buildCounter = 0
)



# 
$BL = @{}
$BL.RepoRoot = (Resolve-Path ( & git rev-parse --show-toplevel))
$BL.BuildDateTime = ((Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ"))
$BL.BuildProjectPath = (Split-Path $MyInvocation.MyCommand.Path -Parent)
$BL.ScriptsPath = (Join-Path $BL.BuildProjectPath "scripts")
$BL.ToolsPath = (Join-Path $BL.BuildProjectPath "tools")

$BL.BuildOutPath = (Join-Path $BL.RepoRoot ".build" )
$BL.BuildScriptPath = $scriptFile
$BL.ib = (Join-Path $BL.ToolsPath "Invoke-Build\Invoke-Build.ps1")

# import tools
. (Join-Path $BL.ScriptsPath "build-counter.ps1")
#. (Join-Path $BL.PsAutoHelpers "ps\ib-update-tools.ps1")

$BL.BuildCounter = Get-BuildNumber $buildCounter
# Invoke-Build info
Write-Output "Invoke-Build: Script file: $scriptFile"


Write-Output "`$BL values"
$BL.GetEnumerator()| Sort-Object -Property name | Format-Table Name, Value -AutoSize

try {
	# Invoke the build and keep results in the variable Result
	& $BL.ib -File $BL.BuildScriptPath -Result Result  @args
}
catch {
	Write-Output $Result.Error
	Write-Output $_
	exit 1 # Failure
}

$Result.Tasks | Format-Table Elapsed, Name -AutoSize
exit 0
