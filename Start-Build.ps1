param(
    $Task = 'Default'
)

# Install dependencies
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null
Install-Module -Name 'psake', 'PSDeploy', 'BuildHelpers', 'Pester', 'platyps', 'PSScriptAnalyzer', 'PSCoverage', 'CICD', 'PSGitHub' -Scope CurrentUser -AllowClobber -Force -Verbose

# Prepare build environment
$BHVariables = Get-BuildVariables
$env:BHBuildSystem   = $BHVariables.BuildSystem
#$env:BHProjectPath   = Get-Item -Path "$PSScriptRoot\.." | Select-Object -ExpandProperty FullName
$env:BHProjectPath   = (Get-Location).Path
$env:BHBranchName    = $BHVariables.BranchName
$env:BHCommitMessage = $BHVariables.CommitMessage
$env:BHBuildNumber   = $BHVariables.BuildNumber

& git config -l | Where-Object { $_ -like 'remote.origin.url=*' } | ForEach-Object {
    if ( $_ -match 'https://github.com/([^/]+)/([^/]+)(.git)?$' ) {
        $env:GitHubOwner = $Matches[1]
        $env:GitHubRepo = $Matches[2] -replace '.git$', ''
    }
}

# Invoke psake and handle return value
Invoke-psake $PSScriptRoot\psake.ps1 -taskList $Task -nologo
exit ( [int]( -not $psake.build_success ) )