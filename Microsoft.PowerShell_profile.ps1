$BashAliasPwsh = "$PSScriptRoot/bash_alias.ps1"
$Bash2Pwsh = "$PSScriptRoot/bash2pwsh.js"
$BashAlias = "$PSScriptRoot/.alias.zsh"

function bash2pwsh_alias() {
	node $Bash2Pwsh $BashAlias $BashAliasPwsh
	echo "node $Bash2Pwsh $BashAlias $BashAliasPwsh"
}

$PWSHProfile = $PSCommandPath

# if you want to use bash like command in powershell,
# it is recommended to install gow.
# "scoop install gow"

function edit_pwsh_profile {
	code $PWSH_Profile
	echo "code $PWSHProfile"
}

# https://stackoverflow.com/a/69135912/5570400
#
# Pipe output to vscode
#
# Usage :
#   ls | oc
Function Out-Code {
    do {
        $filename = New-Guid
		$filename = $filename.toString() + ".md"
    } while (Test-Path $filename)
    $input > $filename
    code $filename
    Start-Sleep 1
    Remove-Item $filename
}
Set-Alias oc Out-Code

# reload profile script
function re {
	. $PWSHProfile
	echo ". $PWSHProfile"
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
