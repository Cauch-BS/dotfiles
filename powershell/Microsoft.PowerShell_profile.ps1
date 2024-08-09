Invoke-Expression (&starship init powershell)
fnm env --use-on-cd | Out-String | Invoke-Expression
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Remove the existing alias
if (Test-Path Alias:ls) {
  Remove-Item Alias:ls -Force
}

# Define the new function
function ls {
  & '~\.cargo\bin\eza.exe' --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions
}
