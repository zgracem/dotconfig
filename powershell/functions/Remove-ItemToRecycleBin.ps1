function Remove-ItemToRecycleBin {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName,
            HelpMessage = "Specifies the path(s) of the item(s) to be recycled.")]
        [String[]] $Path
    )

    process {
        ForEach ($File in $Path) {
            $TargetItem = Get-Item -Path $File -ErrorAction Stop
            $TargetName = $TargetItem.FullName

            if ($PSCmdlet.ShouldProcess($TargetName, "Move to Recycle Bin")) {
                Add-Type -AssemblyName Microsoft.VisualBasic
                if (Test-Path -Path $TargetName -PathType Container) {
                    [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory($TargetName,
                        "OnlyErrorDialogs", "SendToRecycleBin")
                }
                else {
                    [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($TargetName,
                        "OnlyErrorDialogs", "SendToRecycleBin")
                }
            }
        }
    }
}
Set-Alias -Name recycle -Value Remove-ItemToRecycleBin
