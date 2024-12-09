complete -c hdiutil --no-files

complete -c hdiutil -o verbose -d "extra progress and diagnostic output"
complete -c hdiutil -o quiet -d "close stdout and stderr"
complete -c hdiutil -o debug -d "be very verbose"
complete -c hdiutil -n "__fish_is_nth_arg 2" -o help -d "print help for this verb"
complete -c hdiutil -n __fish_use_subcommand -a help -d "display more detailed help"

# Common options

complete -c hdiutil -o plist -d "output in plist format" -n "__fish_seen_subcommand_from attach checksum compact convert create erasekeys imageinfo info isencrypted mountvol plugin resize verify"
complete -c hdiutil -o puppetstrings -d "progress updates for other programs" -n "__fish_seen_subcommand_from attach burn checksum compact convert create verify"
complete -c hdiutil -o srcimagekey -d "key/value pair for disk image recognition" -n "__fish_seen_subcommand_from burn checksum chpass compact convert fsid imageinfo pmap resize verify"
complete -c hdiutil -o tgtimagekey -d "key/value pair for any image created" -n "__fish_seen_subcommand_from convert create"
complete -c hdiutil -o encryption -x -a "AES-128 AES-256" -d "specify algorithm" -n "__fish_seen_subcommand_from attach burn checksum compact convert create fsid imageinfo pmap resize verify"
complete -c hdiutil -o stdinpass -d "read null-terminated passphrase from stdin" -n "__fish_seen_subcommand_from attach burn checksum compact convert create fsid imageinfo pmap resize verify"
complete -c hdiutil -o agentpass -d "force prompting for a passphrase" -n "__fish_seen_subcommand_from create"
complete -c hdiutil -o recover -rF -d "keychain containing certificate secret" -n "__fish_seen_subcommand_from attach chpass"
complete -c hdiutil -o certificate -rF -d "secondary access certificate" -n "__fish_seen_subcommand_from convert create"
complete -c hdiutil -o cacert -rF -d "certificate authority file or dir" -n "__fish_seen_subcommand_from convert create"
complete -c hdiutil -o insecurehttp -d "ignore SSL validation failures" -n "__fish_seen_subcommand_from convert create"
complete -c hdiutil -o shadow -rF -d "shadow of primary image data" -n "__fish_seen_subcommand_from attach burn checksum compact convert fsid imageinfo pmap resize"

# attach

complete -c hdiutil -n __fish_use_subcommand -a attach -d "attach disk image"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -rF
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o readonly -d "force device to be read-only"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o readwrite -d "attempt to override read-only"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o nokernel -d "attach with a helper process"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o kernel -d "attach without a helper process"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o notremoveable -d "prevent image from being detached"
set -l hdiutil_attach_mount_opts '
    required\tfail\ with\ no\ mounts
    optional\tcontinue\ with\ no\ mounts
    suppressed\tsame\ as\ -nomount
'
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o mount -x -a $hdiutil_attach_mount_opts -d "whether to mount filesystems"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o nomount -d "same as -mount suppressed"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o mountroot -rF -d "mount volumes at subdir"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o mountrandom -rF -d "randomize mount point names"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o mountpoint -rF -d "mount point for single volume"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o nobrowse -d "make volumes invisible to Finder"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o owners -x -a "on off" -d "whether to honor ownership"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o drivekey -x -d "key/value pair to set in IOKit registry"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o section -x -d "attach subsection of image"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o verify -d "verify image"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o noverify -d "don't verify image"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o ignorebadchecksums -d "ignore bad checksums"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o noignorebadchecksums -d "abort on bad checksums"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o autoopen -d "open volumes in the Finder"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o noautoopen -d "don't open volumes in the Finder"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o autoopenro -d "open read-only volumes"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o noautoopenro -d "don't open read-only volumes"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o autoopenrw -d "open read/write volumes"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o noautoopenrw -d "don't open read/write volumes"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o autofsck -d "force automatic filesystem check"
complete -c hdiutil -n "__fish_seen_subcommand_from attach" -o noautofsck -d "don't force automatic filesystem check"

# detach

complete -c hdiutil -n __fish_use_subcommand -a detach -d "detach disk image from system"
complete -c hdiutil -n "__fish_seen_subcommand_from detach" -r -F
complete -c hdiutil -n "__fish_seen_subcommand_from detach" -o force -d "ignore open files on mounted volumes"

# verify

complete -c hdiutil -n __fish_use_subcommand -a verify -d "compare data to internal image checksum"
complete -c hdiutil -n "__fish_seen_subcommand_from verify" -rF

# create

complete -c hdiutil -n __fish_use_subcommand -a create -d "create a disk image"
set -l hdiutil_size_specs '
    512b\t512 sectors
    360k\t360 kB
    360k\t360 kB
'
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_is_nth_arg 3" -o size -x -a $hdiutil_size_specs -d "size of image like mkfile(8)"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_is_nth_arg 3" -o sectors -d "size in 512-byte sectors"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_is_nth_arg 3" -o megabytes -d "size in MB"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_is_nth_arg 3" -o srcfolder -rF -d "source for fresh filesystem"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_is_nth_arg 3" -o srcdevice -rF -d "use blocks from device"
complete -c hdiutil -n "__fish_seen_subcommand_from create" -rF
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o pubkey -d "public key(s) to encrypt image"
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o align -x -d "size of final data partition"
set -l hdiutil_create_types '
    UDIF\tcreates UDRW
    SPARSE\tcreates UDSP
    SPARSEBUNDLE\tcreates UDSB
'
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o type -x -a $hdiutil_create_types -d "format of empty image"
set -l hdiutil_filesystems '
    UDF\tUniversal\ Disk\ Format
    MS-DOS\ FAT12\t
    MS-DOS\tMS-DOS\ FAT
    MS-DOS\ FAT16\t
    MS-DOS\ FAT32\t
    HFS+\tMac\ OS\ Extended
    Case-sensitive\ HFS+\tMac\ OS\ Extended
    Case-sensitive\ Journaled\ HFS+\tMac\ OS\ Extended
    Journaled\ HFS+\tMac\ OS\ Extended
    ExFAT\t
    Case-sensitive\ APFS\t
    APFS\t
'
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o fs -x -a $hdiutil_filesystems -d "filesystem"
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o volname -x -d "name of new filesystem"
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o uid -x -a "(__fish_complete_user_ids)" -d "owner of new volume's root"
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o gid -x -a "(__fish_complete_group_ids)" -d "group of new volume's root"
set -l hdiutil_create_modes '
    500\tu=rx,go=
    700\tu=rwx,go=
    755\tu=rwx,go=rx
'
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o mode -x -a $hdiutil_create_modes -d "octal mode of new volume's root"
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o autostretch -d "don't make stretchable"
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o noautostretch -d "make stretchable"
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o stretch -x -d "stretch size"
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o fsargs -x -d "args to newfs program"
set -l hdiutil_layouts '
    MBRSPUD\tsingle\ partition\ MBR
    SPUD\tsingle\ partition\ Apple
    UNIVERSAL\ CD\tCD/DVD
    NONE\tno\ partition\ map
    GPTSPUD\tsingle\ partition,\ GUID
    SPCD\tsingle\ partition,\ CD/DVD
    UNIVERSAL\ HD\thard\ disk
    ISOCD\tsingle\ partition,\ ISO\ CD/DVD
'
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o layout -x -a $hdiutil_layouts -d "specify partition layout"
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o library -rF -d "alternate layout library bundle"
complete -c hdiutil -n "__fish_seen_subcommand_from create" -o partitionType -x -d "partition type"
set -l hdiutil_formats '
    UDRO\tread-only
    UDCO\tADC\ compressed
    UDZO\tcompressed
    UDBZ\tbzip2\ compressed
    ULFO\tlzfse\ compressed
    ULMO\tlzma\ compressed
    UFBI\tentire\ device
    IPOD\tiPod\ image
    UDSB\tsparsebundle
    UDSP\tsparse
    UDRW\tread/write
    UDTO\tDVD/CD\ master
'
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_seen_argument -o srcfolder -o srcdevice" -o format -x -a $hdiutil_formats -d "final image format"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_seen_argument -o srcdevice" -o segmentSize -x -d "maximum segment size"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_seen_argument -o srcfolder" -o crossdev -d "cross boundaries on source fs"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_seen_argument -o srcfolder" -o nocrossdev -d "don't cross boundaries on source fs"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_seen_argument -o srcfolder" -o scrub -d "skip temporary files"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_seen_argument -o srcfolder" -o noscrub -d "don't skip temporary files"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_seen_argument -o srcfolder" -o anyowners -d "don't fail if user can't ensure ownership"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_seen_argument -o srcfolder" -o noanyowners -d "fail if user can't ensure ownership"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_seen_argument -o srcfolder" -o skipunreadable -d "skip unreadable files"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_seen_argument -o srcfolder" -o atomic -d "copy then rename files"
complete -c hdiutil -n "__fish_seen_subcommand_from create; and __fish_seen_argument -o srcfolder" -o copyuid -x -a "(__fish_complete_user_ids)" -d "perform copy as user"

# convert

complete -c hdiutil -n __fish_use_subcommand -a convert -d "convert an image into a different format"
complete -c hdiutil -n "__fish_seen_subcommand_from convert" -rF
complete -c hdiutil -n "__fish_seen_subcommand_from convert" -o format -x -a $hdiutil_formats -d "convert to format"
complete -c hdiutil -n "__fish_seen_subcommand_from convert" -o outfile -rF -d "output file"
complete -c hdiutil -n "__fish_seen_subcommand_from convert" -o align -x -d "size of converted partition"
complete -c hdiutil -n "__fish_seen_subcommand_from convert" -o pmap -d "add partition map"
complete -c hdiutil -n "__fish_seen_subcommand_from convert" -o segmentSize -x -d "specify segment size"
complete -c hdiutil -n "__fish_seen_subcommand_from convert" -o tasks -x -d "number of threads for compression"

# burn

complete -c hdiutil -n __fish_use_subcommand -a burn -d "burn an image to optical media"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -rF
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o device
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o testburn
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o anydevice

complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o eject -d "eject after burning"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o noeject -d "don't eject after burning"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o verifyburn -d "verify contents after burn"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o noverifyburn -d "don't verify contents after burn"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o addpmap -d "add partition map if needed"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o noaddpmap -d "never add partition map"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o skipfinalfree -d "skip final free partition"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o noskipfinalfree -d "don't skip final free partition"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o optimizeimage -d "optimize filesystem for burning"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o nooptimizeimage -d "don't optimize filesystem for burning"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o forceclose -d "close disc after burning"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o noforceclose -d "don't close disc after burning"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o synthesize -d "synthesize a hybrid filesystem"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o nosynthesize -d "don't synthesize a hybrid filesystem"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o nounderrun -d "disable buffer underrun protection"
set -l hdiutil_burn_speeds '
    1\t1x speed
    2\t2x speed
    4\t4x speed
    8\t8x speed
    max\tdefault
'
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o speed -x -a $hdiutil_burn_speeds -d "burn speed factor"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o sizequery -d "calculate required size w/out burning"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o erase -d "quickly erase media"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o fullerase -d "erase all sectors on media"
complete -c hdiutil -n "__fish_seen_subcommand_from burn" -o list -d "list all burning devices"

# makehybrid

complete -c hdiutil -n __fish_use_subcommand -a makehybrid -d "generate cross-platform hybrid images"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -rF
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -s o -rF -d "output image"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o hfs -d "generate HFS+ filesystem"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o iso -d "generate ISO9660 Level 2 filesystem"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o joliet -d "generate Joliet ISO9660 extensions"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o udf -d "generate UDF filesystem"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o hfs‐blessed‐directory -rF -d "path to bless for booting"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o hfs‐openfolder -rF -d "auto-open folder in Finder"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o hfs‐startupfile‐size -x -d "allocate startup file in bytes"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o abstract‐file -rF -d "path to abstract file"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o bibliography‐file -rF -d "path to bibliography file"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o copyright‐file -rF -d "path to copyright file"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o application -x -d "application string"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o preparer -x -d "preparer string"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o publisher -x -d "publisher string"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o system‐id -x -d "system ID string"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o keep‐mac‐specific -d "include files like .DS_Store"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o eltorito‐boot -rF -d "path to El Torito boot image"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid; and __fish_seen_argument -o eltorito-boot" -o hard‐disk‐boot -d "use El Torito HD emulation"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid; and __fish_seen_argument -o eltorito-boot" -o no‐emul‐boot -d "use El Torito no-emulation"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid; and __fish_seen_argument -o eltorito-boot" -o no‐boot -d "mark image as non-bootable"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid; and __fish_seen_argument -o no‐emul‐boot" -o boot‐load‐seg -d "load data at segment address"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid; and __fish_seen_argument -o no‐emul‐boot" -o boot‐load‐size -d "number of 512B sectors to load"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid; and __fish_seen_argument -o eltorito-boot" -o eltorito‐platform -d "platform ID in boot catalog"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid; and __fish_seen_argument -o eltorito-boot" -o eltorito‐specification -x -d "specify complex layouts"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o udf‐version -x -a "1.02 1.50" -d "filesystem version to generate"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o default‐volume‐name -x -d "default volume name for all filesystems"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o hfs‐volume‐name -d "HFS+ volume name only"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o iso‐volume‐name -d "ISO9660 volume name only"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o joliet‐volume‐name -d "Joliet volume name only"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o udf‐volume‐name -d "UDF volume name only"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o hide‐all -x -d "glob of files to hide"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o hide‐hfs -x -d "glob of files to hide in HFS+"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o hide‐iso -x -d "glob of files to hide in ISO9660"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o hide‐joliet -x -d "glob of files to hide in Joliet"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o hide‐udf -x -d "glob of files to hide in UDF"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o only‐udf -x -d "glob of files to only include in UDF"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o only‐iso -x -d "glob of files to only include in ISO"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o only‐joliet -x -d "glob of files to only include in Joliet"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o print-size -d "estimate maximum image size"
complete -c hdiutil -n "__fish_seen_subcommand_from makehybrid" -o plistin -d "use a plist on stdin for parameters"

# compact

complete -c hdiutil -n __fish_use_subcommand -a compact -d "compacts a disk image"
complete -c hdiutil -n "__fish_seen_subcommand_from compact" -rF
complete -c hdiutil -n "__fish_seen_subcommand_from compact" -o batteryallowed -d "allow compacting on battery power"
complete -c hdiutil -n "__fish_seen_subcommand_from compact" -o sleepallowed -d "allow machine to idle while compacting"

# info

complete -c hdiutil -n __fish_use_subcommand -a info -d "display information about attached images"

# checksum

complete -c hdiutil -n __fish_use_subcommand -a checksum -d "calculate checksums for images"
complete -c hdiutil -n "__fish_seen_subcommand_from checksum" -rF
set -l hdiutil_checksum_types '
    UDIF‐CRC32\tCRC‐32\ image
    UDIF‐MD5\tMD5\ image
    CRC32\tCRC‐32
    MD5\tMD5
    SHA\tSHA
    SHA1\tSHA‐1
    SHA256\tSHA‐256
    SHA384\tSHA‐384
    SHA512\tSHA‐512
'
complete -c hdiutil -n "__fish_seen_subcommand_from checksum" -o type -x -a $hdiutil_checksum_types -d "checksum type"

# chpass

complete -c hdiutil -n __fish_use_subcommand -a chpass -d "change passphrase for a given image"
complete -c hdiutil -n "__fish_seen_subcommand_from chpass" -rF
complete -c hdiutil -n "__fish_seen_subcommand_from chpass" -o oldstdinpass -d "read NUL-terminated old password from stdin"
complete -c hdiutil -n "__fish_seen_subcommand_from chpass" -o newstdinpass -d "read NUL-terminated new password from stdin"

# erasekeys

complete -c hdiutil -n __fish_use_subcommand -a erasekeys -d "erase encryption keys"
complete -c hdiutil -n "__fish_seen_subcommand_from erasekeys" -rF

# fsid

complete -c hdiutil -n __fish_use_subcommand -a fsid -d "print filesystem(s) info"
complete -c hdiutil -n "__fish_seen_subcommand_from fsid" -rF

# mountvol

complete -c hdiutil -n __fish_use_subcommand -a mountvol -d "mount a volume"
complete -c hdiutil -n "__fish_seen_subcommand_from mountvol" -rF

# unmount

complete -c hdiutil -n __fish_use_subcommand -a unmount -d "unmount a mounted partition"
complete -c hdiutil -n "__fish_seen_subcommand_from unmount" -rF
complete -c hdiutil -n "__fish_seen_subcommand_from unmount" -o force -d "ignore open files"

# imageinfo

complete -c hdiutil -n __fish_use_subcommand -a imageinfo -d "print information about a given image"
complete -c hdiutil -n "__fish_seen_subcommand_from imageinfo" -rF
complete -c hdiutil -n "__fish_seen_subcommand_from imageinfo" -o format -d "only print image format"
complete -c hdiutil -n "__fish_seen_subcommand_from imageinfo" -o checksum -d "only print image checksum"

# isencrypted

complete -c hdiutil -n __fish_use_subcommand -a isencrypted -d "determines if a disk image is encrypted"
complete -c hdiutil -n "__fish_seen_subcommand_from isencrypted" -rF

# plugins

complete -c hdiutil -n __fish_use_subcommand -a plugins -d "display information about DiskImages plugins"

# resize

complete -c hdiutil -n __fish_use_subcommand -a resize -d "resize partition or image"
complete -c hdiutil -n "__fish_seen_subcommand_from resize" -rF
complete -c hdiutil -n "__fish_seen_subcommand_from resize; and __fish_is_nth_arg 3" -o size -x -a $hdiutil_size_specs -d "size of image"
complete -c hdiutil -n "__fish_seen_subcommand_from resize; and __fish_is_nth_arg 3" -o sectors -d "size in 512-byte sectors"
complete -c hdiutil -n "__fish_seen_subcommand_from resize" -o sectors -d "size in 512-byte sectors"
complete -c hdiutil -n "__fish_seen_subcommand_from resize" -o fsargs -x -d "args to newfs program"
complete -c hdiutil -n "__fish_seen_subcommand_from resize" -o imageonly -d "only resize image file"
complete -c hdiutil -n "__fish_seen_subcommand_from resize" -o partitiononly -d "only resize partition"
complete -c hdiutil -n "__fish_seen_subcommand_from resize" -o partitionID -x -d "partition ID to resize"
complete -c hdiutil -n "__fish_seen_subcommand_from resize" -o nofinalgap -d "allow elimination of trailing gap"
complete -c hdiutil -n "__fish_seen_subcommand_from resize" -o limits -d "display size info w/out resizing"

# pmap

complete -c hdiutil -n __fish_use_subcommand -a pmap -d "display the partition map of an image or device"
complete -c hdiutil -n "__fish_seen_subcommand_from pmap" -rF
set -l hdiutil_pmap_reports -o{simple,standard,complete,diagnostic}
complete -c hdiutil -n "__fish_seen_subcommand_from pmap; and not __fish_seen_argument $hdiutil_pmap_reports" -o simple -d "minimal report"
complete -c hdiutil -n "__fish_seen_subcommand_from pmap; and not __fish_seen_argument $hdiutil_pmap_reports" -o standard -d "standard report"
complete -c hdiutil -n "__fish_seen_subcommand_from pmap; and not __fish_seen_argument $hdiutil_pmap_reports" -o complete -d "complete report"
complete -c hdiutil -n "__fish_seen_subcommand_from pmap; and not __fish_seen_argument $hdiutil_pmap_reports" -o diagnostic -d "diagnostic report"
complete -c hdiutil -n "__fish_seen_subcommand_from pmap" -o endoffsets -d "indicate last block of each partition"
complete -c hdiutil -n "__fish_seen_subcommand_from pmap; and not __fish_seen_argument -o shims" -o nofreespace -d "suppress all free space reporting"
complete -c hdiutil -n "__fish_seen_subcommand_from pmap; and not __fish_seen_argument -o nofreespace" -o shims -d "report free space <32 sectors"
complete -c hdiutil -n "__fish_seen_subcommand_from pmap" -o uuids -d "show per‐instance UUIDs for each partition"
