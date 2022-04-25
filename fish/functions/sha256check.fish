function sha256check -a sum file
    if not set -q argv[2]
        echo >&2 Usage: (status function) CHECKSUM FILE
        return 1
    end
    sha256sum -c (printf "%s  %s" $sum $file | psub)
end
