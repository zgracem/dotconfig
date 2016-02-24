flip()
{
    <<< "${@:-$(</dev/stdin)}" \
    sed "y/abcdefghijklmnopqrstuvwxyz,'?!./ɐqɔpǝɟƃɥᴉɾʞlɯuodbɹsʇnʌʍxʎz',¿¡?/" \
    | rev
}
