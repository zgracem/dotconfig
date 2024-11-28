# sc_auth (macOS smart card manager)

complete --no-files -c sc_auth

set -l sc_auth_algorithms '
    sha1\tSHA-1
    sha256\tSHA-256
    ssh\tSHA-256 for SSH
'

set -l sc_auth_encodings '
    hex\tHexadecimal
    b64\tBase64
'

complete -c sc_auth -d "SmartCard authorization setup script"

complete -c sc_auth -n __fish_use_subcommand -a "pair" -d "Pair user with card"
complete -c sc_auth -n __fish_use_subcommand -a "unpair" -d "Unpair user from card(s)"
complete -c sc_auth -n __fish_use_subcommand -a "pairing_ui" -d "Configure pairing UI"
complete -c sc_auth -n __fish_use_subcommand -a "identities" -d "Print hashes of all identities"
complete -c sc_auth -n __fish_use_subcommand -a "list" -d "List public key hashes valid for this user"
complete -c sc_auth -n __fish_use_subcommand -a "changepin" -d "Change or unblock PIV card PIN"
complete -c sc_auth -n __fish_use_subcommand -a "verifypin" -d "Verify PIV card PIN"
complete -c sc_auth -n __fish_use_subcommand -a "enable_for_login" -d "Enable token for login"
complete -c sc_auth -n __fish_use_subcommand -a "filevault" -d "Change FileVault login status"
complete -c sc_auth -n __fish_use_subcommand -a "create-ctk-identity"
complete -c sc_auth -n __fish_use_subcommand -a "delete-ctk-identity"
complete -c sc_auth -n __fish_use_subcommand -a "delete-all-ctk-identities"
complete -c sc_auth -n __fish_use_subcommand -a "list-ctk-identities" -d ""
complete -c sc_auth -n __fish_use_subcommand -a "import-ctk-identities" -d ""
complete -c sc_auth -n __fish_use_subcommand -a "export-ctk-identity" -d ""
complete -c sc_auth -n __fish_use_subcommand -a "create-ctk-csr" -d ""
complete -c sc_auth -n __fish_use_subcommand -a "import-ctk-certificate" -d ""
complete -c sc_auth -n __fish_use_subcommand -a "accept" -d "By key on inserted cards"
complete -c sc_auth -n __fish_use_subcommand -a "remove" -d "Remove all public keys for this user"
complete -c sc_auth -n __fish_use_subcommand -a "hash" -d "Print hashes for keys on inserted card(s)"

complete -c sc_auth -n '__fish_seen_subcommand_from pair unpair pairing_ui list accept remove' -s v -d "Verbose mode"
complete -c sc_auth -n '__fish_seen_subcommand_from pair unpair list filevault accept remove' -s u -x -a "(__fish_complete_users)" -d "User name"
complete -c sc_auth -n '__fish_seen_subcommand_from pair unpair filevault export-ctk-identity delete-ctk-identity create-ctk-csr accept' -s h -x -d "Public key hash"
complete -c sc_auth -n '__fish_seen_subcommand_from pairing_ui' -s s -x -a "status enable disable"
complete -c sc_auth -n '__fish_seen_subcommand_from pairing_ui' -s f -d "Force"
complete -c sc_auth -n '__fish_seen_subcommand_from filevault' -s o -x -a "status enable disable"
complete -c sc_auth -n '__fish_seen_subcommand_from changepin verifypin' -s t -x -d "Token ID"
complete -c sc_auth -n '__fish_seen_subcommand_from changepin' -s u -d "Unblock PIN using PUK"
complete -c sc_auth -n '__fish_seen_subcommand_from verifypin' -s p -x -d "PIN"
complete -c sc_auth -n '__fish_seen_subcommand_from enable_for_login' -s c -x -d "Specify token by com.apple.ctk.class-id"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-identity' -s l -x -d "Label"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-identity' -s k -x -a "p‐256 p‐384 p‐521" -d "Key type"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-identity' -s k -x -a "p‐256‐ne p‐384‐ne" -d "Key type (non-exportable)"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-identity import‐ctk‐identities' -s t -x -a "bio none" -d "Private key protection"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-identity create-ctk-csr' -s N -x -d "Common Name"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-identity create-ctk-csr' -s E -x -d "Email Address"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-identity create-ctk-csr' -s U -d "Organizational Unit Name"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-identity create-ctk-csr' -s O -d "Organization Name"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-identity create-ctk-csr' -s L -d "Locality Name"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-identity create-ctk-csr' -s S -d "State or Province Name"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-identity create-ctk-csr' -s C -d "Country Name"
complete -c sc_auth -n '__fish_seen_subcommand_from list‐ctk‐identities' -s t -x -a $sc_auth_algorithms -d "Algorithm"
complete -c sc_auth -n '__fish_seen_subcommand_from list‐ctk‐identities' -s e -x -a $sc_auth_encodings -d "Encoding"
complete -c sc_auth -n '__fish_seen_subcommand_from import‐ctk‐identities export-ctk-identity' -s f -rF -d "PKCS#12 file"
complete -c sc_auth -n '__fish_seen_subcommand_from import‐ctk‐identities export-ctk-identity' -s p -x -d "PKCS#12 archive password"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-csr' -s h -x -d "CTK identity hash"
complete -c sc_auth -n '__fish_seen_subcommand_from create-ctk-csr' -s f -rF -d "CSR file"
complete -c sc_auth -n '__fish_seen_subcommand_from import‐ctk‐certificate' -s f -rF -d "Certificate file"
complete -c sc_auth -n '__fish_seen_subcommand_from list accept remove' -s d -x -d "Domain"
complete -c sc_auth -n '__fish_seen_subcommand_from list accept hash' -s k -x -d "Key name"
