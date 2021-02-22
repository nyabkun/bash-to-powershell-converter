## !! This is Sample

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