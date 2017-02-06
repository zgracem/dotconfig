PYTHONPATH="$HOME/opt/lib/python/site-packages"

if [ -d "$PYTHONPATH" ]; then
  export PYTHONPATH
else
  unset -v PYTHONPATH
fi
