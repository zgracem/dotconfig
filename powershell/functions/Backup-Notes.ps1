function Backup-Notes
{
    $NotesDir = "$env:OneDrive\Notes"
    # $DateStamp = Get-Date -Format "yyyy-MM-dd"
    # $ArchiveName = "Notes_$DateStamp.zip"
    $ArchiveName = "Notes_{0}.zip" -f (Get-Date -Format "yyyy-MM-dd")
    $MyDesktop = [System.Environment]::GetFolderPath("Desktop")
    $NotesArchive = Join-Path -Path $MyDesktop -Child $ArchiveName

    [System.IO.Compression.ZipFile]::CreateFromDirectory($NotesDir, $NotesArchive, "Optimal", $False)

    $ArchiveDrive = Get-Volume -FileSystemLabel Silver128 -ErrorAction SilentlyContinue
    $ArchiveDir = $ArchiveDrive.DriveLetter + ":\txt"

    if (Test-Path $ArchiveDir) {
        $ArchivedArchive = Join-Path -Path $ArchiveDir -Child $ArchiveName
        Move-Item -Path $NotesArchive -Destination $ArchivedArchive -Force
        Write-Output $ArchivedArchive
    } else {
        Write-Output $NotesArchive
    }
}
