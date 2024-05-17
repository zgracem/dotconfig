function ga { git add $args }
function gc { git commit $args }
function gcm { gc -m $args }
function gca { gc --amend --no-edit $args }
function gd { git diff $args }
function gfetch { git fetch --prune $args }
function gf { gfetch --all $args }
function gpl { gfetch; git merge --ff-only }
function gps { git push $args }
function gs { git status }
