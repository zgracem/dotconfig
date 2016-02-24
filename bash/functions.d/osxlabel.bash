[[ $OSTYPE =~ darwin ]] || return

osxlabel()
{
    local colour="${1,,}"; shift
    local -a files=("$@")

    local -A colours=(
        [none]='01'
        [gray]='03'
        [green]='04'
        [purple]='06'
        [blue]='09'
        [yellow]='0A'
        [red]='0C'
        [orange]='0E'
    )

    if [[ -n ${colours[$colour]} ]]; then
        local hex
        printf -v hex '%018d%s%044d' '0' "${colours[$colour]}" '0'
    else
        z_scold "invalid colour: $colour"
        z_throw "Valid colours are none/gray/green/purple/blue/yellow/red/orange" $EX_USAGE
    fi

    local f
    for f in "${files[@]}"; do
        xattr -wxv com.apple.FinderInfo "$hex" "$f"
    done
}
