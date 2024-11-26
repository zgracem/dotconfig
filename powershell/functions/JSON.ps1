function Read-Json {
    param(
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias("PSPath")]
        [string] $Path
    )

    $Lines = [String]::Join("`r`n", (Get-Content -Path $Path -Raw))
    $JsonData = ConvertFrom-Json -InputObject $Lines
    Write-Output $JsonData | Format-List
}

function Write-Json {
    param(
        [Parameter(Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [System.Object] $InputObject
    )
    process { $InputObject | ConvertTo-Json -Depth 8 | jq "." }
}

Set-Alias -Name fromjson -Value Read-Json
Set-Alias -Name tojson -Value Write-Json
