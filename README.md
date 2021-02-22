# Bash to Powershell Converter

A [node.js](https://en.wikipedia.org/wiki/Node.js) script that converts [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) to [powershell](https://en.wikipedia.org/wiki/PowerShell).

Only simple things like imports and aliases are supported.

```powershell
node bash2pwsh.js .\You-can-test-with-this-bash-script\.bash_profile bash_profile.ps1
```

## .bash_profile [Before]
```bash
## Util

function pipe() {
  local outfile=~/pipe.md
  $@ >& $outfile
  code $outfile
}

## App

alias play_mpc_be='C:/App/MediaPlayerClassic-BE/mpc-be64.exe'
alias code='C:/Dev/VSCode/Code.exe'

## Dir

export d_diary='C:/Ws/diary'
export d_ws='C:/Ws'
export d_App='C:/App'
export d_AppInst='C:/AppInst'
export d_Dev='C:/Dev'

alias cd_diary="cd $d_diary"
alias cd_ws="cd $d_ws"
alias cd_App="cd $d_App"
alias cd_AppInst="cd $d_AppInst"
alias cd_Dev="cd $d_Dev"

## Util Alias

alias la='ls -a'
alias ll='ls -al'
alias exp_open_here='explorer .'

## Git Alias

alias git_hist='git log --oneline --graph --decorate --all'
alias git_com='git commit --allow-empty-message --no-edit'
alias git_conf_global='git config --global --edit'
alias git_conf_local='git config --edit'
function git_add_com_push() {
	git add -A
  git commit --allow-empty-message --no-edit
  git push
}

## Edit

function edit_alias(){
  code ~/.alias.zsh
}
function edit_alias_sh_only(){
  code ~/.alias-sh.zsh
}
function edit_zshrc() {
  code ~/.zshrc
}
function edit_pwsh_profile(){
  code C:/Users/owner/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
}

## Env
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfg
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/share/pkgconfig
```

`>>>`

## bash_profile.ps1 [After]

```powershell
## Util

function pipe() {
  local outfile=C:/msys64/home/owner/pipe.md
  $args | Out-File -FilePath $outfile
  code $outfile
}

## App

Set-Alias -Name play_mpc_be -Value 'C:/App/MediaPlayerClassic-BE/mpc-be64.exe'
Set-Alias -Name code -Value 'C:/Dev/VSCode/Code.exe'

## Dir

$d_diary='C:/Ws/diary'
$d_ws='C:/Ws'
$d_App='C:/App'
$d_AppInst='C:/AppInst'
$d_Dev='C:/Dev'

function cd_diary() { cd $d_diary }
function cd_ws() { cd $d_ws }
function cd_App() { cd $d_App }
function cd_AppInst() { cd $d_AppInst }
function cd_Dev() { cd $d_Dev }

## Util Alias

function la() { ls -a }
function ll() { ls -al }
function exp_open_here() { explorer . }

## Git Alias

function git_hist() { git log --oneline --graph --decorate --all }
function git_com() { git commit --allow-empty-message --no-edit }
function git_conf_global() { git config --global --edit }
function git_conf_local() { git config --edit }
function git_add_com_push() {
	git add -A
  git commit --allow-empty-message --no-edit
  git push
}

## Edit

function edit_alias(){
  code C:/msys64/home/owner/.alias.zsh
}
function edit_alias_sh_only(){
  code C:/msys64/home/owner/.alias-sh.zsh
}
function edit_zshrc() {
  code C:/msys64/home/owner/.zshrc
}
function edit_pwsh_profile(){
  code C:/Users/owner/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
}

## Env
$env:PKG_CONFIG_PATH += ";C:/msys64/usr/local/lib/pkgconfg"
$env:PKG_CONFIG_PATH += ";C:/msys64/usr/local/share/pkgconfig"
echo "Loaded : $PSCommandPath"
```
