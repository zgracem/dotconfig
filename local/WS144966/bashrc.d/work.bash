[[ -d //atco ]] || return

dir_Pdrive="//atco/dept/2100657"
dir_Qdrive="//atco/comp/2100655"
dir_PandC="${dir_Pdrive}/Data/Projects and Construction"

dir_gta="${dir_Qdrive}/Projects/00 UTILITY FILINGS"
dir_myproj="${dir_dropbox}/Projects"
dir_nepcrs="${dir_Pdrive}/Projects/Projects/NE Program/PCR's"
dir_proj="${dir_Pdrive}/Projects/Projects"

dir_clint="${dir_Pdrive}/Data/Projects and Construction/ADMIN/HR/Project Services/Simon's Working Documents/Laryssa's Working Docs/CLINT"

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
