set -l ssh_agent_options '
    allow-remote-pkcs11\tallow\ clients\ to\ load\ libs
    no-restrict-websafe\tpermit\ FIDO\ over\ web\ protocols
'

complete -c ssh-agent -s a -rF -d 'Bind agent to socket'
complete -c ssh-agent -s c -d 'Generate C-shell commands'
complete -c ssh-agent -s D -d 'Foreground mode'
complete -c ssh-agent -s d -d 'Debug mode'
complete -c ssh-agent -s E -x -a "md5 sha256" -d 'Hash algorithm for key fingerprints'
complete -c ssh-agent -s k -d 'Kill current agent by SSH_AGENT_PID'
complete -c ssh-agent -s O -x -a $ssh_agent_options -d 'Specify an option'
complete -c ssh-agent -s P -x -d 'Acceptable paths for PKCS#11/FIDO'
complete -c ssh-agent -s s -d 'Generate Bourne shell commands'
complete -c ssh-agent -s t -x -d 'Maximum identity lifetime'
