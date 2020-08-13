function mkcomp
  set -l src_dir $HOME/var/tmp/help2man
  set -l comp_dir $HOME/.config/fish/completions
  set -l man_files

  for cmd in $argv
    set -l man_file (command man -w $cmd)
    or return

    set -l match (string match -r '.*/(.+?)\.(.+?)(?:\.gz)?' "$man_file")
    or return

    set -l section $match[3]
    set -l man_dir $src_dir/man$section

    command mkdir -p $man_dir
    or return

    help2man --no-info --no-discard-stderr --output=$man_dir/$cmd.$section $cmd
    or return

    set -a man_files $man_dir/$cmd.$section
  end

  set -lx MANPATH $src_dir
  fish_update_completions --manpath --progress --directory=$comp_dir

  command rm -f $man_files
end
