# from `f3fix --list-disk-types`
set -l f3fix_disk_types \
    aix amiga bsd dvh gpt \
    mac msdos pc98 sun atari \
    loop

# from `f3fix --list-fs-types`
set -l f3fix_fs_types \
    zfs udf btrfs nilfs2 ext4 \
    ext3 ext2 f2fs fat32 fat16 \
    hfsx hfs+ hfs jfs swsusp \
    'linux-swap\(v1\)' 'linux-swap\(v0\)' ntfs reiserfs freebsd-ufs \
    hp-ufs sun-ufs xfs apfs2 apfs1 \
    asfs amufs5 amufs4 amufs3 amufs2 \
    amufs1 amufs0 amufs affs7 affs6 \
    affs5 affs4 affs3 affs2 affs1 \
    affs0

complete -c f3fix -x -a "(__fish_complete_blockdevice)"
complete -c f3fix -s a -l first-sec -x -d 'Sector where partition starts'
complete -c f3fix -s b -l boot -d 'Mark partition for boot'
complete -c f3fix -s d -l disk-type -x -a "$f3fix_disk_types" -d 'Disk type of partition table'
complete -c f3fix -s f -l fs-type -x -a "$f3fix_fs_types" -d 'Type of partition file system'
complete -c f3fix -s l -l last-sec -x -d 'Sector where partition ends'
complete -c f3fix -s n -l no-boot -d 'Do not mark partition for boot'
complete -c f3fix -s k -l list-disk-types -d 'List all supported disk types'
complete -c f3fix -s s -l list-fs-types -d 'List all supported file systems'
complete -c f3fix -s '?' -l help -d 'Display help'
complete -c f3fix -l usage -d 'Display usage message'
complete -c f3fix -s V -l version -d 'Display program version'
