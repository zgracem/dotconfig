function ydlq --wraps youtube-dl --description 'Download video(s) quietly in the background'
	ydl -q $argv &
end
