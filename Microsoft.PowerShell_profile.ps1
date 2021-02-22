# C:/Users/owner/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
#
# Hint ::
# New-Item -ItemType HardLink -Name .alias.zsh -Value C:/msys64/home/owner/.alias.zsh
#
node "$PSScriptRoot/bash2pwsh.js" "$PSScriptRoot/.alias.zsh" "$PSScriptRoot/bash_alias.ps1"

$PWSH_Profile = $PSCommandPath

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
	. $PWSH_Profile
}

# https://stackoverflow.com/a/47075453/14820021
."$PSScriptRoot/bash_alias.ps1"

echo "Loaded : $PSCommandPath"