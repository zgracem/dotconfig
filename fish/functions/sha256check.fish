function sha256check -a checksum file -d "Verify the SHA256 checksum of a file"
    if not set -q argv[2]
        echo >&2 Usage: (status function) CHECKSUM FILE
        return 1
    end
    sha256sum -c (printf "%s  %s" $checksum $file | psub)
end
