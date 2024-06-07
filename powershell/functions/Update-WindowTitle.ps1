function Update-WindowTitle
{
    $ThisPath = $Args[0]

    $Parent = Split-Path $ThisPath -Parent
    $CwdBase = Split-Path $ThisPath -Leaf
    $ShortPath = ""
    $Slash = [System.IO.Path]::AltDirectorySeparatorChar

    $ShortPath = if ($Parent.Length -gt 24) {
        $ParentDirs = $Parent.Split([System.IO.Path]::DirectorySeparatorChar)
        $ParentDirs[0] + $Slash + "..." + $Slash + $CwdBase
    }
    else {
        $ThisPath
    }
    $Host.UI.RawUI.WindowTitle = $(hostname) + ":" + $ShortPath
}
