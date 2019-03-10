function ydlp --wraps youtube-dl --description 'Download video(s in parallel)'
  in-path youtube-dl; or return 127
  parallel -k youtube-dl {} ::: $argv
end
