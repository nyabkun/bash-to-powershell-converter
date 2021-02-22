const fs = require('fs')


// Usage
// node bash2pwsh.js path/to/bash_script.sh destfile.ps1

const src = process.argv[2]
const dest = process.argv[3]

const BASH_ROOT = "C:/msys64"
const BASH_HOME = "C:/msys64/home/owner"

const bash = fs.readFileSync(src, 'utf8')
const pwsh = convert(bash);
//console.log("content : " + pwsh);
fs.writeFileSync(dest, pwsh);

function convert(bash) {
    // export d_diary='C:/Ws/diary'
    // >>>
    // $d_diary='C:/Dev'
    bash = bash.replace(/export ([\w_]+)=('.*?')/g, '\$$$1=$2')

    // alias cd_diary=''
    // >>>
    // Set-Alias -Name cd_diary -Value 'cd $d_diary'
    bash = bash.replace(/alias (\w+)=(['"]\w+?['"])/g, 'Set-Alias -Name $1 -Value $2')

    // ## Powershell alias can't use parameters
    //
    // alias cd_diary='cd $d_diary'
    // >>>
    // Set-Alias -Name cd_diary -Value 'cd $d_diary'
    bash = bash.replace(/alias (\w+)=['"](.+?)['"]/g, 'function $1() { $2 }')

    // EDITOR='code'
    // >>>
    // $EDITOR='code'
    bash = bash.replace(/(^(?:\s+)?)(\w+)=('.*?')$/gm, '$1\$$$2=$3')

    // export PATH=$PATH:/usr/bin
    // >>>
    // $env:Path += ";C:/msys64/usr/bin"
    bash = bash.replace(/(?<=[:"'])\/(bin|dev|etc|home|mingw|msys|opt|tmp|usr|var)/g, `${BASH_ROOT}/$1`)
    bash = bash.replace(/export (\w+)=\$\w+:([\w:/\\]+)/g, '\$env:$1 += ";$2"')

    // ~/.bashrc
    // >>>
    // C:/msys64/.bashrc
    bash = bash.replace(/~\//g, `${BASH_HOME}/`)

    // $@
    // >>>
    // $args
    bash = bash.replace(/\$@/g, '\$args')
    bash = bash.replace(/\$(\d)/g, '\$args[$1]')

    // /c/Program Files/
    // >>>
    // C:/Program Files
    bash = bash.replace(/(?:\s|^)\/([cdefghijk])\//im, '$1:/')

    // $args >& $outfile
    // >>>
    // $args Out-File -FilePath $outFile
    bash = bash.replace(/(\S+)\s*>&\s*(\S+)/g,'$1 | Out-File -FilePath $2')

    // $EDITOR C:/msys64/.alias.zsh
    // >>>
    // "$EDITOR C:/msys64/.alias.sh"
    bash += '\necho "Loaded : $PSCommandPath"'

    return bash;
}
