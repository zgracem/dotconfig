# ~/.config/powershell

By default, Windows PowerShell looks for its startup `$PROFILE` scripts in
`%HOME%/Documents/PowerShell`. To align with the use of `XDG_CONFIG_HOME` on
macOS and Linux, for each `.ps1` file in this directory, place a file with the
same name and the following contents in `%HOME%/Documents/PowerShell`:

```powershell
#Requires -Version 7
$CurrentFileBasename = $MyInvocation.MyCommand
$ActualProfile = "$env:UserProfile\.config\powershell\$CurrentFileBasename"
if (Test-Path($ActualProfile)) { . "$ActualProfile" }
```
