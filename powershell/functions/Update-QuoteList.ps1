function Update-QuoteList {
    $local:DownloadsDir = "$env:USERPROFILE\Downloads"
    $local:QuotesDir = "$env:OneDrive\Documents\EWB\Quotes"

    $local:DownloadedQuotes = Get-ChildItem $DownloadsDir\quote_*.pdf
    ForEach ($quote in $DownloadedQuotes) {
        Move-Item -Path $quote -Destination $QuotesDir
    }

    Get-ChildItem "$QuotesDir" `
        | Select-String "[0-9]" -InputObject { $_.BaseName } `
        | Write-Output -InputObject { $_ -replace "[^0-9]", "" } `
        | Set-Clipboard # -PassThru | Tee-Object -FilePath "$QuotesDir\quotes.csv"
}
