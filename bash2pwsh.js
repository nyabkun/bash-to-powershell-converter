const fs = require("fs");

const BASH_ROOT = "C:/msys64";
const BASH_HOME = "C:/msys64/home/owner";

const src = process.argv[2];
const dest = process.argv[3];

try {
  const bash = fs.readFileSync(src, "utf8");
  const pwsh = convert(bash);

  fs.writeFileSync(dest, pwsh);

  console.log(`"${dest}" was created Successfully!`);
} catch (err) {
  console.log(err.message);
}

function convert(bash) {
  // export d_diary='C:/Ws/diary'
  // >>>
  // $d_diary='C:/Dev'
  bash = bash.replace(/export (\w+)=('.*?')/g, "$$$1=$2");

  // alias code='C:/Dev/VSCode/Code.exe'
  // >>>
  // Set-Alias -Name code -Value 'cd $d_diary'
  bash = bash.replace(
    /alias (\w+)=(['"]\S+?['"])/g,
    "Set-Alias -Name $1 -Value $2"
  );

  // ## Powershell alias can't use parameters
  //
  // alias cd_diary='cd $d_diary'
  // >>>
  // Set-Alias -Name cd_diary -Value 'cd $d_diary'
  bash = bash.replace(/alias (\w+)=['"](.+?)['"]/g, "function $1() { $2 }");

  // EDITOR='code'
  // >>>
  // $EDITOR='code'
  bash = bash.replace(/(^(?:\s+)?)(\w+)=('.*?')$/gm, "$1$$$2=$3");

  // export PATH=$PATH:/usr/bin
  // >>>
  // $env:Path += ";C:/msys64/usr/bin"
  bash = bash.replace(
    /(?<=[:"'])\/(bin|dev|etc|home|mingw|msys|opt|tmp|usr|var)/g,
    `${BASH_ROOT}/$1`
  );
  bash = bash.replace(/export (\w+)=\$\w+:([\w:/\\]+)/g, '$env:$1 += ";$2"');

  // ~/.bashrc
  // >>>
  // C:/msys64/.bashrc
  bash = bash.replace(/~\//g, `${BASH_HOME}/`);

  // $@
  // >>>
  // $args
  bash = bash.replace(/\$@/g, "$$args");

  // bash/zsh arg numbers are different from powershell
  // $1
  // >>>
  // $args[0]
  for (let i = 0; i < 10; i++) {
    bash = bash.replace(new RegExp("$" + (i + 1), "g"), "$$args[" + i + "]");
  }

  // local some_variable
  // >>>
  // $some_variable
  bash = bash.replace(/^\s+local\s+(\w+)/gm, "$$$1");

  // /c/Program Files/
  // >>>
  // C:/Program Files
  bash = bash.replace(/(?:\s|^)\/([cdefghijk])\//im, "$1:/");

  // $args >& $outfile
  // >>>
  // $args Out-File -FilePath $outFile
  bash = bash.replace(/(\S+)\s*>&\s*(\S+)/g, "$1 | Out-File -FilePath $2");

  return bash;
}
