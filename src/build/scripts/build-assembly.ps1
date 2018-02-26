function WriteAssembly {
    Param(
        [Parameter(Mandatory=$true)][string]$workDir,
        [Parameter(Mandatory=$true)][string]$assemblyVersion,
        [Parameter(Mandatory=$true)][string]$assemblyFileVersion,
        [Parameter(Mandatory=$true)][string]$assemblyInformationalVersion,
        [Parameter(Mandatory=$true)][string]$productName,
        [Parameter(Mandatory=$true)][string]$copyright,
        [Parameter(Mandatory=$true)][string]$companyName
    )
   
}

function GetAssemblyInfo {
    Param(
        #<major version>.<minor version>.<build number>.<revision> - max 65535
        [Parameter(Mandatory=$false)][string]$assemblyVersion = "1.0.0.0",
        [Parameter(Mandatory=$false)][string]$assemblyFileVersion = "1.0.0.0",
        [Parameter(Mandatory=$false)][string]$assemblyInformationalVersion = "",
        [Parameter(Mandatory=$false)][string]$productName,
        [Parameter(Mandatory=$false)][string]$copyright,
        [Parameter(Mandatory=$false)][string]$companyName
    )
    $sb = [System.Text.StringBuilder]::new()  
    [void]$sb.AppendLine("using System.Reflection;")
    [void]$sb.AppendLine("using System.Runtime.CompilerServices;")
    [void]$sb.AppendLine("using System.Runtime.InteropServices;")
    [void]$sb.AppendLine("[assembly: AssemblyFileVersion(`"$assemblyFileVersion`")]")


    return $sb.ToString();
    

}

#[AssemblyCompany]
#[AssemblyVersion]
#[AssemblyFileVersion]
#[AssemblyInformationalVersion]
#[AssemblyCopyright]
#[AssemblyConfiguration]

GetAssemblyInfo