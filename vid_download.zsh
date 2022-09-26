#!/bin/zsh
zmodload zsh/langinfo

function yt_format () {
	yt-dlp -q -F --check-all-formats --cookies-from-browser chrome "$1"
}

function yt_with_format () {
	yt-dlp --no-playlist --no-overwrites --add-chapters \
	--cookies-from-browser chrome -f "$1" \
	-o "%(title)s.f%(format_id)s.%(ext)s" "$2"
}

function yt () {
	local a b c
	cd /Users/navkaransinghsidhu/Movies/
	[[ ! -n "$1" ]] || yt_format "$1"
	echo -ne "\t Enter Video Format : "
	read a
	[[ ! -n "$a" ]] || yt_with_format "$a" "$1"
	echo -ne "\t Enter Audio Format : "
	read b
	[[ ! -n "$b" ]] || yt_with_format "$b" "$1"
	echo -ne "\t Enter output filename : "
	read c
	[[ ! -n "$c" ]] || merge_streams *$a* *$b* "$c"
}

function merge_streams () {
	ffmpeg -loglevel error -i "$1" -i "$2" -c copy -map 0:v -map 1:a "$3"
}
