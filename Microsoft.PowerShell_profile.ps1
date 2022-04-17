
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

echo "PS Profile [Editable] :"
echo "    $PSCommandPath"
echo "Bash Alias [Editable] :"
echo "    $BashAlias"
echo "Bash2Pwsh / Conversion Script [Editable]"
echo "    $Bash2Pwsh"
echo "PW Bash Alias (is Read from PS Profile) [Auto Generated] :"
echo "    $BashAliasPwsh"
echo ""
echo "If you want to edit both PowerShell and Bash aliases at the same time :"
echo "    1. Edit Bash Alias ('$BashAlias')"
echo "    2. Type 'bash2pwsh_alias' in PowerShell (convert Bash Alias to Powershell Profile)"
echo "    3. Type 're' in PowerShell (reload profile)"

# https://github.com/dahlbyk/posh-git
Import-Module posh-git
# https://github.com/joonro/Get-ChildItemColor
Import-Module Get-ChildItemColor