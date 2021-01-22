#!/bin/bash

# Shortcut command to use youtube-dl
# Video - {135} mp4 480p
# Audio - {251} webm 48K
# Use `youtube-dl -F <VIDEO_URL>` to get available format code list
function yt-dl() {
  youtube-dl -f '135' $1 && youtube-dl -f '251' $1
}

# Combine ytdl downloaded file to MKV
function make-mkv() {
  mkvmerge --ui-language en_US --output "$1.mkv" --language 0:und '(' "$1.mp4" ')' --language 0:eng --default-track 0:yes '(' "$1.webm" ')' --track-order 0:0,1:0
}

# Convert mkv file to mp4 using ffmpeg
function mkv-to-mp4() {
  ffmpeg -i "$1.mkv" -c:v copy "$1.mp4"
}

# Delete downloaded file after make-mkv is success
function del-file() {
  rm "$1.mp4" && rm "$1.webm"
}

# Combine all command above
function ytdl() {
  local videoName=$(youtube-dl --get-filename $1 | sed 's/\.[^.]*$//')
  yt-dl $1 && make-mkv "$videoName" && del-file "$videoName" && mkv-to-mp4 "$videoName" && rm "$videoName.mkv"
}

# youtube-dl 360p
function ytdl-360() {
  local videoName=$(youtube-dl --get-filename $1 | sed 's/\.[^.]*$//')
  youtube-dl -f '18' $1 && youtube-dl -f '251' $1 && make-mkv "$videoName" && del-file "$videoName" && mkv-to-mp4 "$videoName" && rm "$videoName.mkv"
}

# Make multiple CBZ file
function make-cbz() {
  zip -rj "$1.cbz" "$1"
}

# Starting httpd & mysqld
function lampp() {
  if [[ $# -eq 0 ]] ; then
    echo "need flags for this command, --start or --stop"
  fi

  for i in "$@"
  do
    case $i in
      --start)
        systemctl start httpd && systemctl start mysqld
        ;;
      --stop)
        systemctl stop httpd && systemctl stop mysqld
        ;;
      --restart)
        systemctl restart httpd
        ;;
      *)
        ;;
    esac
  done
}

# restart the swap
function restart-swap() {
  sudo swapoff -a && sudo swapon -a
}

# get random file name

function random-file() {
  ls | sort -R | tail -$N | while read file; do
    echo $file
  done
}

