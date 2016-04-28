[[ -d //atco ]] || return

dir_Pdrive="//atco/dept/2100657"
dir_Qdrive="//atco/comp/2100655"
dir_Sdrive="//atco/dept/0200625"

dir_proj="${dir_Pdrive}/Projects/Projects"
dir_nepcrs="${dir_proj}/NE Program/PCR's"
dir_gta="${dir_Qdrive}/Projects/00 UTILITY FILINGS"
dir_regulatory="${dir_Sdrive}/DATA/Regulatory"

dir_myproj="${dir_dropbox}/Projects"

export ${!dir_*}

# -----------------------------------------------------------------------------

fixir()
{
    local t
    for t in "$@"; do
        if [[ -d $t ]]; then
            ir_fix "$t"/*.docx
        elif [[ -f $t ]]; then
            ir_fix "$t"
        else
            return 66
        fi
    done
}
