auc::url()
{
  local document="$1"
  local regex='^((U|DA)?([[:digit:]]{4})-[[:digit:]]+$|[[:digit:]]+-D[[:digit:]]+-([[:digit:]]{4}))$'
  auc_url='http://www.auc.ab.ca/'

  if [[ -z $document ]]; then
    read document < /dev/clipboard
  fi

  if [[ $document =~ $regex ]]; then
    local year="${BASH_REMATCH[3]}${BASH_REMATCH[4]}"
  else
    scold "$FUNCNAME: invalid document number: $document"
    return 65
  fi

  case $document in
    U*)
      # utility order
      auc_url+='applications/orders/utility-orders/Utility%20Orders'
      ;;
    *-D*)
      # new-style decision (PPPPP-D##-YYYY)
      auc_url+='regulatory_documents/ProceedingDocuments'
      ;;
    *)
      # old-style decision (YYYY-###)
      auc_url+='applications/decisions/Decisions'
      ;;
  esac

  auc_url+="/$year/$document.pdf"

  printf '%s' "$auc_url"
}

auc()
{
  local auc_url

  if auc_url=$(auc::url "$1"); then
    "$BROWSER" "$auc_url"
  else
    return
  fi
}
