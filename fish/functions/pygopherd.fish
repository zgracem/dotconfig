function pygopherd
    argparse s/stop -- $argv; or return

    if set -q _flag_stop[1]
        set -l pidfile ~/var/run/pygopherd.pid

        if test -f $pidfile
            kill -INT (cat $pidfile)
            and rm $pidfile
        else
            echo >&2 "pygopherd pidfile not found!"
            return 1
        end
        return
    end

    cd ~/opt/etc/pygopherd; or return
    PYTHONPATH=. bin/pygopherd conf/local.conf
    cd -
end
