# Prompt
Import-Module posh-git

# Load prompt config
function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'hardi.omp.json'
oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression

# Icons
Import-Module -Name Terminal-Icons

##########################################
# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl+k -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+j -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+Backspace -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key Ctrl+Delete -Function KillWord

## Cursor movement
Set-PSReadLineKeyHandler -Key Ctrl+h -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+Alt+h -Function BackwardChar
Set-PSReadLineKeyHandler -Key Ctrl+l -Function ForwardWord
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
Set-PSReadLineKeyHandler -Key Ctrl+Alt+l -Function ForwardChar

## Suggestions
Set-PSReadlineKeyHandler -Chord Alt+k -Function PreviousSuggestion
Set-PSReadlineKeyHandler -Chord Alt+j -Function NextSuggestion

###########################################

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

##########################################
# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

## Git Aliases
Set-Alias gco 'git checkout'

## Other
Set-Alias c clear


####### ALIASES

# kubectl aliases
Function kubectlCurrentContext {kubectl config current-context}

Set-Alias -Name k -Value kubectl
Set-Alias -Name kc -Value kubectlCurrentContext

# git aliases
Function gitstatus {git status $args}
Function gitadd {git add $args}
Function gitcheckout {git checkout $args}
Function gitdiff {git diff $args}
Function gitpull {git pull $args}
Function gitbranch {git branch $args}
Set-Alias -Name gs -Value gitstatus
Set-Alias -Name ga -Value gitadd
Set-Alias -Name gco -Value gitcheckout
Set-Alias -Name gd -Value gitdiff
Set-Alias -Name gpu -Value gitpull
Set-Alias -Name gb -Value gitbranch

# ado aliases
Function startskyrise {cd D:\git\ado\src; ./init.ps1 -KeepPsReadLine $True}
Set-Alias -Name ado -Value startskyrise

# gitops aliases
Function gitopsdir {cd D:\git\gitops\gitops}
Set-Alias -Name gitops -Value gitopsdir

Set-Alias -Name rider -Value 'C:\Program Files\JetBrains\JetBrains Rider 2021.3.3\bin\rider64'

##########################################

# Utilities
function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue |
	Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}


# Write the current path as the terminal title
$gitDir = git rev-parse --show-toplevel 2>$null
if ($null -ne $gitDir) {
	$Host.UI.RawUI.WindowTitle = $gitDir
} else {
	$Host.UI.RawUI.WindowTitle = $currentPath
}
