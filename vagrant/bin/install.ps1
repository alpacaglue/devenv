
# Download Git
$githubDownload = 'https://github-windows.s3.amazonaws.com/GitHubSetup.exe'
$githubDestination = "$Env:USERPROFILE\Downloads\GitHubSetup.exe"
Invoke-WebRequest -Uri $githubDownload -OutFile $githubDestination
Invoke-Expression "& `"$githubDestination`""

# Create profile and add git
If (-Not (Test-Path $profile)) {New-Item -path $profile -type file –force}
Set-ExecutionPolicy Unrestricted -Scope CurrentUser

If ( ($profile | %{$_ -match [Regex]::Escape("$env:LOCALAPPDATA\GitHub\shell.ps1")} ) -contains $false) {
    Add-Content $profile "`n. (Resolve-Path `"$env:LOCALAPPDATA\GitHub\shell.ps1`")"
}
If ( ($profile | %{$_ -match [Regex]::Escape("$env:github_posh_git\profile.example.ps1")} ) -contains $false) {
    Add-Content $profile "`n. `"$env:github_posh_git\profile.example.ps1`"`n"
}
If ( ($profile | %{$_ -match [Regex]::Escape("C:\Program Files\Oracle\VirtualBox")} ) -contains $false) {
    Add-Content $profile "`n`$env:Path += `";C:\Program Files\Oracle\VirtualBox`"`n"
}
. $profile

# Clone DevEnv Repository
$devEnvRepo = 'https://github.com/mttjohnson/devenv.git'
git clone $devEnvRepo server
cd C:\server
git checkout develop

# Download and install VirtualBox
$virtualBoxDownload = 'http://download.virtualbox.org/virtualbox/5.1.2/VirtualBox-5.1.2-108956-Win.exe'
$virtualBoxDestination = "$Env:USERPROFILE\Downloads\VirtualBox-5.1.2-108956-Win.exe"
Invoke-WebRequest -Uri $virtualBoxDownload -OutFile $virtualBoxDestination
Invoke-Expression "& `"$virtualBoxDestination`""

# Download and install Vagrant
$vagrantDownload = 'https://releases.hashicorp.com/vagrant/1.8.5/vagrant_1.8.5.msi'
$vagrantDestination = "$Env:USERPROFILE\Downloads\vagrant_1.8.5.msi"
Invoke-WebRequest -Uri $vagrantDownload -OutFile $vagrantDestination
Invoke-Expression "& `"$vagrantDestination`""


