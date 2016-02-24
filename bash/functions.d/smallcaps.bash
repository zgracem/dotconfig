smallcaps()
{
    <<< "${@:-$(</dev/stdin)}" \
    sed 'y/abcdefghijklmnopqrstuvwxyz/ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘ_ʀꜱᴛᴜᴠᴡxʏᴢ/'
}
