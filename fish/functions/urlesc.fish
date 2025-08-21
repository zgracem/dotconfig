function urlesc
    set -l rbscript 'puts ARGF.read.codepoints.map { |c| "%%%02x" % c  }.join'
    echo -n $argv | ruby -e $rbscript
end
