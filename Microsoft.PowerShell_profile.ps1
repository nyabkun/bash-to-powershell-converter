
# https://stackoverflow.com/q/9406434/14820021
# ."./wrap.ps1"
# ."./color_ls.ps1"

# C:/Users/owner/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
#
# Hint ::
# New-Item -ItemType HardLink -Name .alias.zsh -Value C:/msys64/home/owner/.alias.zsh
#

$BashAliasPwsh = "$PSScriptRoot/bash_alias.ps1"
$Bash2Pwsh = "$PSScriptRoot/bash2pwsh.js"
$BashAlias = "$PSScriptRoot/.alias.zsh"

# Detect File Content Change
$ScriptHash = "$PSScriptRoot/."

## TODO
# Get-FileHash $Bash2Pwsh >

# node $Bash2Pwsh $BashAlias $BashAliasPwsh

$PWSHProfile = $PSCommandPath

# Hard link
function ln($src, $dest) {
	New-Item -ItemType HardLink -Name "$dest" -Value "$src"
}

function l() {
	ls | Sort-Object Mode, Name, LastWriteTime
	# dir | Sort-Object LastWriteTime
}

function ls_last_write_time() {
	ls | Sort-Object Mode, LastWriteTime
	# dir | Sort-Object LastWriteTime
}

function touch {
	echo $null >> $args
}

function edit_pwsh_profile {
	code $PWSH_Profile
}

# reload profile script
function re {
	. $PWSHProfile
}

# https://stackoverflow.com/a/47075453/14820021
.$BashAliasPwsh

echo "PS Profile    : $PSCommandPath"
echo "Bash Alias    : $BashAlias"
echo "Bash2Pwsh     : $Bash2Pwsh"
echo "PW Bash Alias : $BashAliasPwsh"

# https://github.com/dahlbyk/posh-git
Import-Module posh-git
# https://github.com/joonro/Get-ChildItemColor
Import-Module Get-ChildItemColor