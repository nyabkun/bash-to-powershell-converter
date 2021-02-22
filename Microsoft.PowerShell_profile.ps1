# C:/Users/owner/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
#
# Hint ::
# New-Item -ItemType HardLink -Name .alias.zsh -Value C:/msys64/home/owner/.alias.zsh
#

$BashAliasPwsh = "$PSScriptRoot/bash_alias.ps1"

node "$PSScriptRoot/bash2pwsh.js" "$PSScriptRoot/.alias.zsh" $BashAliasPwsh.toString()

$PWSHProfile = $PSCommandPath

# Hard link
function ln($src, $dest) {
	New-Item -ItemType HardLink -Name "$dest" -Value "$src"
}

function touch {
	echo $null >> $args
}

function edit_pwsh_profile {
	code $PWSH_Profile
}

# refresj
function re {
	. $PWSHProfile
}

# https://stackoverflow.com/a/47075453/14820021
.$BashAliasPwsh.toString()

echo "Loaded : $PSCommandPath"