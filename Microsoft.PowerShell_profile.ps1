######## POSH-GIT

###################################################################################
# Tab completion test
##
# PSReadLine, see https://github.com/PowerShell/PSReadLine
##

## behaviour of Tab key autocomplete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
## From docs:
## With these bindings, up arrow/down arrow will work like PowerShell/cmd if the
## current command line is blank. If you've entered some text though, it will
## search the history for commands that start with the currently entered text.
##
## Like zsh completion.
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

###################################################################################

# Import and register kubectl autocompletion
Import-Module -Name PSKubectlCompletion
Register-KubectlCompletion

###################################################################################

# ... Import-Module for posh-git here ...
Import-Module posh-git

###################################################################################
# Background colors

$GitPromptSettings.AfterStash.BackgroundColor = 0x3465A4
$GitPromptSettings.AfterStatus.BackgroundColor = 0x3465A4
$GitPromptSettings.BeforeIndex.BackgroundColor = 0x3465A4
$GitPromptSettings.BeforeStash.BackgroundColor = 0x3465A4
$GitPromptSettings.BeforeStatus.BackgroundColor = 0x3465A4
$GitPromptSettings.BranchAheadStatusSymbol.BackgroundColor = 0x3465A4
$GitPromptSettings.BranchBehindAndAheadStatusSymbol.BackgroundColor = 0x3465A4
$GitPromptSettings.BranchBehindStatusSymbol.BackgroundColor = 0x3465A4
$GitPromptSettings.BranchColor.BackgroundColor = 0x3465A4
$GitPromptSettings.BranchGoneStatusSymbol.BackgroundColor = 0x3465A4
$GitPromptSettings.BranchIdenticalStatusSymbol.BackgroundColor = 0x3465A4
$GitPromptSettings.DefaultColor.BackgroundColor = 0x3465A4
$GitPromptSettings.DelimStatus.BackgroundColor = 0x3465A4
$GitPromptSettings.ErrorColor.BackgroundColor = 0x3465A4
$GitPromptSettings.IndexColor.BackgroundColor = 0x3465A4
$GitPromptSettings.LocalDefaultStatusSymbol.BackgroundColor = 0x3465A4
$GitPromptSettings.LocalStagedStatusSymbol.BackgroundColor = 0x3465A4
$GitPromptSettings.LocalWorkingStatusSymbol.BackgroundColor = 0x3465A4
$GitPromptSettings.StashColor.BackgroundColor = 0x3465A4
$GitPromptSettings.WorkingColor.BackgroundColor = 0x3465A4

# Foreground colors

$GitPromptSettings.AfterStash.ForegroundColor = 0xF49797
$GitPromptSettings.AfterStatus.ForegroundColor = 0x729FCF
$GitPromptSettings.BeforeStash.ForegroundColor = 0xF49797
$GitPromptSettings.BeforeStatus.ForegroundColor = 0x729FCF
$GitPromptSettings.BranchAheadStatusSymbol.ForegroundColor = 0x8AE234
$GitPromptSettings.BranchBehindAndAheadStatusSymbol.ForegroundColor = 0xFCE94F
$GitPromptSettings.BranchBehindStatusSymbol.ForegroundColor = 0xF49797
$GitPromptSettings.BranchColor.ForegroundColor = 0xFBFBFB
$GitPromptSettings.BranchGoneStatusSymbol.ForegroundColor = 0x729FCF
$GitPromptSettings.BranchIdenticalStatusSymbol.ForegroundColor = 0x729FCF
$GitPromptSettings.DefaultColor.ForegroundColor = 0xB5BBAE
$GitPromptSettings.DelimStatus.ForegroundColor = 0x729FCF
$GitPromptSettings.ErrorColor.ForegroundColor = 0xF49797
$GitPromptSettings.IndexColor.ForegroundColor = 0x2EC3C3
$GitPromptSettings.StashColor.ForegroundColor = 0xF49797
$GitPromptSettings.WorkingColor.ForegroundColor = 0xFCE94F

# Prompt shape

$GitPromptSettings.AfterStatus.Text = " "
$GitPromptSettings.BeforeStatus.Text = " "
$GitPromptSettings.BranchAheadStatusSymbol.Text = ""
$GitPromptSettings.BranchBehindStatusSymbol.Text = ""
$GitPromptSettings.BranchGoneStatusSymbol.Text = ""
$GitPromptSettings.BranchBehindAndAheadStatusSymbol.Text = ""
$GitPromptSettings.BranchIdenticalStatusSymbol.Text = ""
$GitPromptSettings.BranchUntrackedText = ""
$GitPromptSettings.DelimStatus.Text = " ॥"
$GitPromptSettings.LocalStagedStatusSymbol.Text = ""
$GitPromptSettings.LocalWorkingStatusSymbol.Text = ""

$GitPromptSettings.EnableStashStatus = $false
$GitPromptSettings.ShowStatusWhenZero = $false

#$GitPromptSettings.DefaultPromptPrefix.Text = ""
$GitPromptSettings.PathStatusSeparator.Text=""
###################################################################################

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

# cd aliases
Function onecsv2 {Set-Location -Path E:\ms\1cs}
Function spacerepo {Set-Location -Path E:\ms\space}
Function onecsv1 {Set-Location -Path E:\VSO\src\Compliance}

Set-Alias -Name space -Value spacerepo
Set-Alias -Name csv2 -Value onecsv2
Set-Alias -Name csv1 -Value onecsv1

# 1CS v1 aliases
Function onecsv1_w3p {c:\Windows\System32\inetsrv\appcmd.exe list wp}
Function onecsv1_job {c:\Windows\System32\tasklist.exe /FI "SERVICES eq Compliance-DevFabric-JobAgent_IN_0"}

Set-Alias -Name csv1web -Value onecsv1_w3p
Set-Alias -Name csv1job -Value onecsv1_job

#ilspy
Function ilspy {E:\scripts\ILSpy-win-x64-Release\ILSpy}

Function stern {E:\scripts\stern_windows_amd64.exe}

###################################################################################

######## INI FILE PARSER

function parseIniFile {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [String] $Inputfile
    )

    if ($Inputfile -eq "") {
        Write-Error "Ini File Parser: No file specified or selected to parse."
        Break
    }
    else {

        $ContentFile = Get-Content $Inputfile
        # commented Section
        $COMMENT_CHARACTERS = ";"
        # match section header
        $HEADER_REGEX = "\[+[A-Z0-9._ %<>/#+-]+\]"

        $OccurenceOfComment = 0
        $ContentComment = $ContentFile | Where-Object { ($_ -match "^\s*$COMMENT_CHARACTERS") -or ($_ -match "^$COMMENT_CHARACTERS") } | % {
            [PSCustomObject]@{ Comment = $_ ;
                Index                  = [Array]::IndexOf($ContentFile, $_)
            }
            $OccurenceOfComment++
        }

        $COMMENT_INI = @()
        foreach ($COMMENT_ELEMENT in $ContentComment) {
            $COMMENT_OBJ = New-Object PSObject
            $COMMENT_OBJ | Add-Member  -type NoteProperty -name Index -value $COMMENT_ELEMENT.Index
            $COMMENT_OBJ | Add-Member  -type NoteProperty -name Comment -value $COMMENT_ELEMENT.Comment
            $COMMENT_INI += $COMMENT_OBJ
        }

        $CONTENT_USEFUL = $ContentFile | Where-Object { ($_ -notmatch "^\s*$COMMENT_CHARACTERS") -or ($_ -notmatch "^$COMMENT_CHARACTERS") }
        $ALL_SECTION_HASHTABLE = $CONTENT_USEFUL | Where-Object { $_ -match $HEADER_REGEX } | % { [PSCustomObject]@{ Section = $_ ; Index = [Array]::IndexOf($CONTENT_USEFUL, $_) } }
        #$ContentUncomment | Select-String -AllMatches $HEADER_REGEX | Select-Object -ExpandProperty Matches

        $SECTION_INI = @()
        foreach ($SECTION_ELEMENT in $ALL_SECTION_HASHTABLE) {
            $SECTION_OBJ = New-Object PSObject
            $SECTION_OBJ | Add-Member  -type NoteProperty -name Index -value $SECTION_ELEMENT.Index
            $SECTION_OBJ | Add-Member  -type NoteProperty -name Section -value $SECTION_ELEMENT.Section
            $SECTION_INI += $SECTION_OBJ
        }

        $INI_FILE_CONTENT = @()
        $NBR_OF_SECTION = $SECTION_INI.count
        $NBR_MAX_LINE = $CONTENT_USEFUL.count

        #*********************************************
        # select each lines and value of each section
        #*********************************************
        for ($i = 1; $i -le $NBR_OF_SECTION ; $i++) {
            if ($i -ne $NBR_OF_SECTION) {
                if (($SECTION_INI[$i - 1].Index + 1) -eq ($SECTION_INI[$i].Index )) {
                    $CONVERTED_OBJ = @() #There is nothing between the two section
                }
                else {
                    $SECTION_STRING = $CONTENT_USEFUL | Select-Object -Index  (($SECTION_INI[$i - 1].Index + 1)..($SECTION_INI[$i].Index - 1)) | Out-String
                    $CONVERTED_OBJ = convertfrom-stringdata -stringdata $SECTION_STRING
                }
            }
            else {
                if (($SECTION_INI[$i - 1].Index + 1) -eq $NBR_MAX_LINE) {
                    $CONVERTED_OBJ = @() #There is nothing between the two section
                }
                else {
                    $SECTION_STRING = $CONTENT_USEFUL | Select-Object -Index  (($SECTION_INI[$i - 1].Index + 1)..($NBR_MAX_LINE - 1)) | Out-String
                    $CONVERTED_OBJ = convertfrom-stringdata -stringdata $SECTION_STRING
                }
            }
            $CURRENT_SECTION = New-Object PSObject
            $CURRENT_SECTION | Add-Member -Type NoteProperty -Name Section -Value $SECTION_INI[$i - 1].Section
            $CURRENT_SECTION | Add-Member -Type NoteProperty -Name Content -Value $CONVERTED_OBJ
            $INI_FILE_CONTENT += $CURRENT_SECTION
        }

        return $INI_FILE_CONTENT
    }
}

###################################################################################

######## PROMPT

set-content Function:prompt {
    # Start with a blank line, for breathing room :)
    Write-Host ""

    # Reset the foreground color to default
    $Host.UI.RawUI.ForegroundColor = "Gray"

    # Write ERR for any PowerShell errors
    if ($Error.Count -ne 0) {
        Write-Host "$([char]27)[38;5;131m$([char]27)[38;5;227;48;5;131m  ERR $([char]27)[0m$([char]27)[38;5;131m$([char]27)[0m" -NoNewLine
        $Error.Clear()
    }

    # Write non-zero exit code from last launched process
    if ($LASTEXITCODE -ne "") {
        Write-Host "$([char]27)[38;5;131m$([char]27)[38;5;227;48;5;131m  $LASTEXITCODE $([char]27)[0m$([char]27)[38;5;131m$([char]27)[0m" -NoNewLine
        $LASTEXITCODE = ""
    }

    # Write any custom prompt environment (f.e., from vs2017.ps1)
    if (get-content variable:\PromptEnvironment -ErrorAction Ignore) {
        Write-Host " $([char]27)[38;5;254;48;5;54m$PromptEnvironment$([char]27)[0m" -NoNewLine
    }

    # Write the current kubectl context
	# ************* DISABLED *************
    if ($false -and $null -ne (Get-Command "kubectl" -ErrorAction Ignore)) {
        $currentContext = (& kubectl config current-context 2> $null)
        if ($Error.Count -eq 0) {
            Write-Host " $([char]27)[38;5;112;48;5;242m  $([char]27)[38;5;254m$currentContext $([char]27)[0m" -NoNewLine
        }
        else {
            $Error.Clear()
        }
    }
	
	# Write the current kubectl context
	$K8sContext=$(Get-Content ~/.kube/config | Select-String -Pattern "^current-context: (.*)$" | ForEach-Object { $_.Matches[0].Groups[1].Value})
	if ($K8sContext) {
		Write-Host "$([char]27)[38;5;242m$([char]27)[38;5;112;48;5;242m  $([char]27)[38;5;254m$K8sContext $([char]27)[0m$([char]27)[38;5;242m$([char]27)[0m" -NoNewLine
    }

    # Write the current public cloud Azure CLI subscription
    # NOTE: You will need sed from somewhere (for example, from Git for Windows)
    if (Test-Path ~/.azure/clouds.config) {
        $cloudsConfig = parseIniFile ~/.azure/clouds.config
        $azureCloud = $cloudsConfig | Where-Object { $_.Section -eq "[AzureCloud]" }
        if ($null -ne $azureCloud) {
            $currentSub = $azureCloud.Content.subscription
            if ($null -ne $currentSub) {
                $currentAccount = (Get-Content ~/.azure/azureProfile.json | ConvertFrom-Json).subscriptions | Where-Object { $_.id -eq $currentSub }
                if ($null -ne $currentAccount) {
                    Write-Host "$([char]27)[38;5;30m$([char]27)[38;5;227;48;5;30m  $([char]27)[38;5;254m$($currentAccount.name) $([char]27)[0m$([char]27)[38;5;30m$([char]27)[0m" -NoNewLine
                }
            }
        }
    }

    # Write the current Git information
    if ($null -ne (Get-Command "Get-GitDirectory" -ErrorAction Ignore)) {
        if (Get-GitDirectory -ne $null) {
            Write-Host "$([char]27)[38;2;52;101;164m█$(Write-VcsStatus)$([char]27)[38;2;52;101;164m" -NoNewLine
        }
    }

    # Write the current directory, with home folder normalized to ~
    $currentPath = (get-location).Path.replace($home, "~")
    $idx = $currentPath.IndexOf("::")
    if ($idx -gt -1) { $currentPath = $currentPath.Substring($idx + 2) }

    Write-Host "$([char]27)[38;5;28m█$([char]27)[38;5;227;48;5;28m $([char]27)[38;5;254m$currentPath $([char]27)[0m$([char]27)[38;5;28m$([char]27)[0m" -NoNewline

    # Write the current path as the terminal title
    $gitDir = git rev-parse --show-toplevel 2>$null
    if ($null -ne $gitDir) {
        $Host.UI.RawUI.WindowTitle = $gitDir
    } else {
        $Host.UI.RawUI.WindowTitle = $currentPath
    }

    # Reset LASTEXITCODE so we don't show it over and over again
    $global:LASTEXITCODE = 0

    # Write one + for each level of the pushd stack
    if ((get-location -stack).Count -gt 0) {
        Write-Host " " -NoNewLine
        Write-Host (("+" * ((get-location -stack).Count))) -NoNewLine -ForegroundColor Cyan
    }

    # Newline
    Write-Host ""

    # Determine if the user is admin, so we color the prompt green or red
    $isAdmin = $false
    $isDesktop = ($PSVersionTable.PSEdition -eq "Desktop")

    if ($isDesktop -or $IsWindows) {
        $windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $windowsPrincipal = new-object 'System.Security.Principal.WindowsPrincipal' $windowsIdentity
        $isAdmin = $windowsPrincipal.IsInRole("Administrators") -eq 1
    }
    else {
        $isAdmin = ((& id -u) -eq 0)
    }

    if ($isAdmin) { $color = "Red"; }
    else { $color = "Green"; }

    # Write PS> for desktop PowerShell, pwsh> for PowerShell Core
    if ($isDesktop) {
        Write-Host " PS>" -NoNewLine -ForegroundColor $color
    }
    else {
        Write-Host " pwsh>" -NoNewLine -ForegroundColor $color
    }

    # Always have to return something or else we get the default prompt
    return " "
}

###################################################################################