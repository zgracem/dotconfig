function init-ruby-lsp -d "Initialize directory for use with ruby-lsp"
    set -l skel ~/Developer/skel/ruby

    path is -f $PWD/.rubocop.yml
    or cp -aiv $skel/.rubocop.yml $PWD/.rubocop.yml

    path is -f $PWD/.ruby-version
    or rbenv global >$PWD/.ruby-version

    path is -f $PWD/Gemfile
    or cp -aiv $skel/Gemfile $PWD/Gemfile

    path is -f $PWD/Gemfile.lock
    or bundle install
end
