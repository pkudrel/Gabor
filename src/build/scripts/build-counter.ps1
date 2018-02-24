
function exec {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)][scriptblock]$Command,
        [Parameter(Mandatory=$false, Position=1)][string]$ErrorMessage = ("Failed executing {0}" -F $Command)
    )

    & $Command
    if ($LASTEXITCODE -ne 0) {
        throw ("exec: " + $ErrorMessage)
    }
}

function Ensure-DirExists ($path){

	if((Test-Path $path) -eq 0)
	{
			mkdir $path | out-null;
    }
}

<#
.Synopsis
	Get current repository root
#>
function Get-GitRepoRoot
{
	 $path = exec { git rev-parse --show-toplevel } "Get-GitRepoRoot: Problem with git"
	 return $path 
}


<#
.Synopsis
	Get work dir psgitversion
#>
function Get-PsGitVersionWorkDirPath
{
	$repoRootPath =	Get-GitRepoRoot
	$gitDirPath = Join-Path $repoRootPath ".git"
	if((Test-Path $gitDirPath) -eq 0){ throw ("Git dir not found")} 
	$GitVersionDirPath = Join-Path $gitDirPath "psgitversion"
	Ensure-DirExists $GitVersionDirPath
	return $GitVersionDirPath
}

<#
.Synopsis
	Use local build counter
#>

function Get-LocalBuildNumber {

	$GitVersionDirPath = Get-PsGitVersionWorkDirPath
	$counterFilePath = Join-Path $GitVersionDirPath "local-counter.txt"
	
	$defauleValue = 1;
	$result = $defauleValue;
	if (Test-Path $counterFilePath) 
	{
		$firstline = Get-Content $counterFilePath -totalcount 1
		[int]$b = $null #used after as refence
		if(([int32]::TryParse($firstline, [ref]$b )) -eq  $true)
		{
			$next = $b + 1;
			$result = $next	
		}
	}
	$result | Out-File $counterFilePath
	return $result
}

function Get-BuildNumber {

    Param(
        [Parameter(Mandatory=$true)]$counter

    )
    if ($counter -eq 0) {
        return Get-LocalBuildNumber
    } else {
        return $result
    }
   
	
}
