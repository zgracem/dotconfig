function ydlq --wraps youtube-dl --description 'Download video(s) quietly in the background'
    ydlp -q $argv &
end
