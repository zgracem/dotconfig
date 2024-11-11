# ssh-keygen

command -sq ssh-keygen; or return

# reset built-in completions
complete --erase -c ssh-keygen
complete --no-files -c ssh-keygen

set -l ssh_keygen_kdf_rounds '
    8\t
    16\tdefault
    32\t
'
set -l ssh_keygen_bits '
    1024\tRSA\ minimum
    3072\tRSA\ maximum
    256\t
    384\t
    512\t
'

set -l ssh_keygen_formats '
    RFC4716\tRFC\ 4716/SSH2\ public/private\ key
    PKCS8\tPKCS8\ public/private\ key
    PEM\tPEM\ public\ key
'

set -l ssh_keygen_types '
    ecdsa\tECDSA
    ecdsa-sk\tECDSA-SK
    ed25519\tED25519
    ed25519-sk\tED25519-SK
    rsa\tRSA
    ssh-rsa\tSHA1\t
    rsa-sha2-256\t
    rsa-sha2-512\t
'

complete -c ssh-keygen -s A -d 'Generate host keys of all default types'
complete -c ssh-keygen -s a -x -a "$ssh_keygen_kdf_rounds" -d 'KDF rounds used when saving a private key'
complete -c ssh-keygen -s B -d 'Show the bubblebabble digest'
complete -c ssh-keygen -s b -x -a "$ssh_keygen_bits" -d 'Specifies the number of bits in the key to create'
complete -c ssh-keygen -s C -x -d 'Provides a new comment'
complete -c ssh-keygen -s c -d 'Request changing comment'
complete -c ssh-keygen -s D -x -d 'Download public keys provided by library'
complete -c ssh-keygen -s E -x -a "md5 sha256" -d 'Hash algorithm for key fingerprints'
complete -c ssh-keygen -s e -d 'Export public key'
complete -c ssh-keygen -s F -x -d 'Search for hostname:port in known_hosts'
complete -c ssh-keygen -s f -rF -d 'Specifies the filename'
complete -c ssh-keygen -s g -n "__fish_seen_argument -s r" -d 'Use generic DNS format'
complete -c ssh-keygen -s H -d 'Hash a known_hosts file'
complete -c ssh-keygen -s h -d 'Create a host certificate instead of a user certificate'
complete -c ssh-keygen -s I -x -d 'Specify key identity'
complete -c ssh-keygen -s i -d 'Convert unencrypted key to OpenSSH'
complete -c ssh-keygen -s K -d 'Download resident keys from FIDO authenticator'
complete -c ssh-keygen -s k -d 'Generate a KRL file'
complete -c ssh-keygen -s L -d 'Prints one or more certificates'
complete -c ssh-keygen -s l -d 'Show fingerprint of specified public key file'
complete -c ssh-keygen -s M -x -a generate -d 'Generate candidate DH-GEX parameters'
complete -c ssh-keygen -s M -x -a screen -d 'Screen candidate DH-GEX parameters'
complete -c ssh-keygen -s m -n '__fish_seen_argument -s i -s e -s p' -x -a $ssh_keygen_formats -d 'Specify a key format for key generation'
complete -c ssh-keygen -s N -x -d 'Provides the new passphrase'
complete -c ssh-keygen -s n -d 'Specify principal(s)'
complete -c ssh-keygen -s O -d 'Specify a key/value option'
complete -c ssh-keygen -s P -x -d 'Provides the (old) passphrase'
complete -c ssh-keygen -s p -d 'Request changing the passphrase of a private key'
complete -c ssh-keygen -s Q -d 'Test whether keys have been revoked in a KRL'
complete -c ssh-keygen -s q -d 'Silence ssh-keygen'
complete -c ssh-keygen -s R -x -d 'Removes all keys for hostname from known_hosts'
complete -c ssh-keygen -s r -x -d 'Print SSHFP fingerprint resource record'
complete -c ssh-keygen -s s -x -d 'Sign a public key using this certificate'
complete -c ssh-keygen -s t -x -a "$ssh_keygen_types" -d 'Specifies the type of key to create'
complete -c ssh-keygen -s U -n '__fish_seen_argument -s s -s Y' -d 'Indicate CA key resides in ssh-agent'
complete -c ssh-keygen -s u -d 'Update a KRL'
complete -c ssh-keygen -s V -x -d 'Validity interval when signing a certificate'
complete -c ssh-keygen -s v -d 'Verbose mode'
complete -c ssh-keygen -s w -x -d 'Path to library used for FIDO auth.'
complete -c ssh-keygen -s Y -x -a find-principals -d "Find principal(s) associated with public key"
complete -c ssh-keygen -s Y -x -a match-principals -d "Find principal matching -I NAME"
complete -c ssh-keygen -s Y -x -a check-novalidate -d "Check signature for valid structure"
complete -c ssh-keygen -s Y -x -a sign -d "Cryptographically sign using an SSH key"
complete -c ssh-keygen -s y -d 'Read private file and print public key'
complete -c ssh-keygen -s Z -x -a "(ssh -Q cipher)" -d 'Cipher to use for encryption'
complete -c ssh-keygen -s z -x -d 'Serial/version number'

# Options
complete -c ssh-keygen -s O -n "__fish_seen_argument -s Y" -x -a "hashalg=sha256" -d "Use SHA256 hash algorithm"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s Y" -x -a "hashalg=sha512" -d "Use SHA512 hash algorithm"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s Y" -x -a "print-pubkey" -d "Print full public key"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s Y" -x -a "verify-time=" -d "Timestamp for validating signatures"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s r; and __fish_seen_argument -s D" -x -a "hashalg=sha1" -d "Use SHA1 hash algorithm"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s r; and __fish_seen_argument -s D" -x -a "hashalg=sha256" -d "Use SHA256 hash algorithm"

# Certificates
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "clear" -d "Clear all enabled permissions"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "critical:" -d "Include critical option"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "extension:" -d "Include extension"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "force-command=" -d "Force execution of a command"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "no-agent-forwarding" -d "Disable ssh-agent forwarding"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "no-port-forwarding" -d "Disable port forwarding"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "no-pty" -d "Disable PTY allocation"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "no-user-rc" -d "Disable execution of ~/.ssh/rc by sshd"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "no-x11-forwarding" -d "Disable X11 forwarding"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "permit-agent-forwarding" -d "Allow ssh-agent(1) forwarding"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "permit-port-forwarding" -d "Allow port forwarding"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "permit-pty" -d "Allow PTY allocation"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "permit-user-rc" -d "Allow execution of ~/.ssh/rc by sshd"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "permit-X11-forwarding" -d "Allow X11 forwarding"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "no-touch-required" -d "Do not require demonstration of user presence"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "source-address=" -d "Restrict valid source addresses"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s s" -x -a "verify-required" -d "Require signatures indicate that the user was verified"

# Moduli Generation
complete -c ssh-keygen -s O -n "__fish_seen_argument -s M" -x -a "lines=" -d "Exit after screening this number of lines"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s M" -x -a "start-line=" -d "Start screening at this line number"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s M" -x -a "checkpoint=" -d "Write last line processed to this file"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s M" -x -a "memory=" -d "Memory to use, in megabytes"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s M" -x -a "start=" -d "Start point, in hex"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s M" -x -a "prime-tests=" -d "Screening primality tests"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s M" -x -a "generator=2" -d "Desired generator"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s M" -x -a "generator=3" -d "Desired generator"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s M" -x -a "generator=5" -d "Desired generator"

# FIDO authentication
complete -c ssh-keygen -s O -n "__fish_seen_argument -s t" -x -a "application" -d "Override default application/origin string"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s t" -x -a "challenge=" -d "Path to a challenge string"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s t" -x -a "device" -d "Specify a fido(4) device to use"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s t" -x -a "no-touch-required" -d "Do not require touch events when signing"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s t" -x -a "resident" -d "Store key handle on the FIDO authenticator itself"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s t" -x -a "user" -d "Username associated with resident key"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s t" -x -a "verify-required" -d "Require user verification for each signature"
complete -c ssh-keygen -s O -n "__fish_seen_argument -s t" -x -a "write-attestation=" -d "Record attestation data"
