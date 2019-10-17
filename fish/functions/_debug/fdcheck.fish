function fdcheck --description 'Test the status of file descriptors'
  for fd in stdin stdout stderr
    echo -ne "$fd:\t"
    if isatty $fd; echo "open"; else; echo "closed"; end
  end
end
