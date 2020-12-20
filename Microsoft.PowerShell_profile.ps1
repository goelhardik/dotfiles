
######## POSH-GIT

Import-Module posh-git

# Background colors
$baseBackgroundColor = "DarkBlue"
$GitPromptSettings.AfterBackgroundColor = $baseBackgroundColor
$GitPromptSettings.AfterStashBackgroundColor = $baseBackgroundColor
$GitPromptSettings.BeforeBackgroundColor = $baseBackgroundColor
$GitPromptSettings.BeforeIndexBackgroundColor = $baseBackgroundColor
$GitPromptSettings.BeforeStashBackgroundColor = $baseBackgroundColor
$GitPromptSettings.BranchAheadStatusBackgroundColor = $baseBackgroundColor
$GitPromptSettings.BranchBackgroundColor = $baseBackgroundColor
$GitPromptSettings.BranchBehindAndAheadStatusBackgroundColor = $baseBackgroundColor
$GitPromptSettings.BranchBehindStatusBackgroundColor = $baseBackgroundColor
$GitPromptSettings.BranchGoneStatusBackgroundColor = $baseBackgroundColor
$GitPromptSettings.BranchIdenticalStatusToBackgroundColor = $baseBackgroundColor
$GitPromptSettings.DelimBackgroundColor = $baseBackgroundColor
$GitPromptSettings.IndexBackgroundColor = $baseBackgroundColor
$GitPromptSettings.ErrorBackgroundColor = $baseBackgroundColor
$GitPromptSettings.LocalDefaultStatusBackgroundColor = $baseBackgroundColor
$GitPromptSettings.LocalStagedStatusBackgroundColor = $baseBackgroundColor
$GitPromptSettings.LocalWorkingStatusBackgroundColor = $baseBackgroundColor
$GitPromptSettings.StashBackgroundColor = $baseBackgroundColor
$GitPromptSettings.WorkingBackgroundColor = $baseBackgroundColor

# Foreground colors
$GitPromptSettings.AfterForegroundColor = "Blue"
$GitPromptSettings.BeforeForegroundColor = "Blue"
$GitPromptSettings.BranchForegroundColor = "White"
$GitPromptSettings.BranchGoneStatusForegroundColor = "Blue"
$GitPromptSettings.BranchIdenticalStatusToForegroundColor = "White"
$GitPromptSettings.DefaultForegroundColor = "White"
$GitPromptSettings.DelimForegroundColor = "Blue"
$GitPromptSettings.IndexForegroundColor = "Green"
$GitPromptSettings.WorkingForegroundColor = "Yellow"

# Prompt shape
$GitPromptSettings.AfterText = " "
$GitPromptSettings.BeforeText = "  "
$GitPromptSettings.BranchAheadStatusSymbol = ""
$GitPromptSettings.BranchBehindStatusSymbol = ""
$GitPromptSettings.BranchBehindAndAheadStatusSymbol = ""
$GitPromptSettings.BranchGoneStatusSymbol = ""
$GitPromptSettings.BranchIdenticalStatusToSymbol = ""
$GitPromptSettings.DelimText = " ॥"
$GitPromptSettings.LocalStagedStatusSymbol = ""
$GitPromptSettings.LocalWorkingStatusSymbol = ""
$GitPromptSettings.ShowStatusWhenZero = $false

$GitPromptSettings.EnableFileStatus = $false

######## PROMPT

set-content Function:prompt {
  $title = (get-location).Path.replace($home, "~")
  $idx = $title.IndexOf("::")
  if ($idx -gt -1) { $title = $title.Substring($idx + 2) }

  $windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $windowsPrincipal = new-object 'System.Security.Principal.WindowsPrincipal' $windowsIdentity
  if ($windowsPrincipal.IsInRole("Administrators") -eq 1) { $color = "Red"; }
  else { $color = "Green"; }

  $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

  #if (Get-GitStatus -ne $null) {
   #   write-host " " -NoNewLine
      Write-VcsStatus
  #}

  $global:LASTEXITCODE = 0

  write-host " " -NoNewLine
  write-host $title -NoNewLine  -BackgroundColor DarkMagenta -ForegroundColor White
  write-host " " -NoNewLine
  write-host "PS>" -NoNewLine -ForegroundColor $color

  #$host.UI.RawUI.WindowTitle = $title
  return " "
}

######## ALIASES

##### GIT
del alias:gc -Force
del alias:gp -Force
function gs { git status $args }
function ga { git add $args }
function gp { git pull $args }
function gc { git checkout $args }
function gcom { git commit $args }
function gb { git branch $args }
function gd { git diff $args }
