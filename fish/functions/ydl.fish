function ydl --wraps youtube-dl --description 'Download video(s in parallel)'
	parallel -k youtube-dl {} ::: $argv
end
