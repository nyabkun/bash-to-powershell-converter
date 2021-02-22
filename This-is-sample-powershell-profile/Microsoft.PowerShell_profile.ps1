# !! This is sample
#
# C:/Users/<user_name>/Documents/PowerShell/Microsoft.PowerShell_profile.ps1

node $PSScriptRoot/bash2pwsh.js C:/msys64/home/owner/.alias.zsh ./bash_alias.ps1

# https://stackoverflow.com/a/47075453/14820021
."./bash_alias.ps1"

echo "Loaded : $PSCommandPath"