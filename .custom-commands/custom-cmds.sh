#!/bin/bash

# Convert MKV to MP4
function mkv2mp4() {
  local filePath="$1"
  local filename=${filePath%%.*}

  ffmpeg -i "$1" -c:v copy "$filename.mp4"
}

# Make multiple CBZ file
function make-cbz() {
  zip -rj "$1.cbz" "$1"
}

# restart the swap
function restart-swap() {
  sudo swapoff -a && sudo swapon -a
}

function crandr() {
  if [[ $# -eq 0 ]] ; then
    crandr start
  fi

  for arg in "$@"
  do
    case $arg in
      stop)
        xrandr --output VGA1 --off
        shift
        ;;
      start)
        xrandr --newmode "1280x768_60.00"   79.50  1280 1344 1472 1664  768 771 781 798 -hsync +vsync
        xrandr --addmode VGA1 "1280x768_60.00"
        xrandr --output LVDS1 --mode 1366x768
        xrandr --output VGA1 --mode 1280x768_60.00 --right-of LVDS1
        shift
        ;;
    esac
  done
}

# Python custom commands
function get-doujin() {
  $HOME/.custom-commands/get-doujin
}

function testing() {
  $HOME/.custom-commands/testing "$@"
}

function ytdl() {
  $HOME/.custom-commands/ytdl "$1"
}

# Starting httpd & mysqld
function lemp() {
  if [[ $# -eq 0 ]] ; then
    echo "Please provide flags fot this command, --start or --stop"
  fi

  for arg in "$@"
  do
    case $arg in
      --start)
        case $2 in
          all)
            for service in nginx php-fpm7 mariadb
            do
              sudo systemctl start $service.service
            done
            shift
            ;;
          server)
            for service in nginx php-fpm7
            do
              sudo systemctl start $service.service
            done
            shift
            ;;
          db|database)
            sudo systemctl start mariadb.service
            shift
            ;;
          *)
            ;;
        esac
        shift
      ;;
      --stop)
        case $2 in
          all)
            for service in nginx php-fpm7 mariadb
            do
              sudo systemctl stop $service.service
            done
            shift
            ;;
          server)
            for service in nginx php-fpm7
            do
              sudo systemctl stop $service.service
            done
            shift
            ;;
          db|database)
            sudo systemctl stop mariadb.service
            shift
            ;;
          *)
            ;;
        esac
        shift
      ;;
      --restart)
        case $2 in
          all)
            for service in nginx php-fpm7 mariadb
            do
              sudo systemctl restart $service.service
            done
            shift
            ;;
          server)
            for service in nginx php-fpm7
            do
              sudo systemctl restart $service.service
            done
            shift
            ;;
          db|database)
            sudo systemctl restart mariadb.service
            shift
            ;;
          *)
            ;;
        esac
        shift
      ;;
      *)
        ;;
    esac
  done
}


# function bw-add() {
  # local loginTemplate=$(bw get template item.login | jq ".username=\"$2\" | .password=\"$3\"")
  # bw get template item | jq ".name=\"$1\" | .login=$loginTemplate" | bw encode | bw create item
# }

# # Shortcut command to use youtube-dl
# # Video - {135} mp4 480p
# # Audio - {251} webm 48K
# # Use `youtube-dl -F <VIDEO_URL>` to get available format code list
# function yt-dl() {
  # local videoQuality=135
  # local audioQuality=251
  # youtube-dl -f "$videoQuality" $1 && youtube-dl -f "$audioQuality" $1
# }

# # Combine ytdl downloaded file to MKV
# function make-mkv() {
  # mkvmerge --ui-language en_US --output "$1.mkv" --language 0:und '(' "$1.mp4" ')' --language 0:eng --default-track 0:yes '(' "$1.webm" ')' --track-order 0:0,1:0
# }

# # Convert mkv file to mp4 using ffmpeg
# function mkv-to-mp4() {
  # ffmpeg -i "$1.mkv" -c:v copy "$1.mp4"
# }

# # Delete downloaded file after make-mkv is success
# function del-file() {
  # rm "$1.mp4" && rm "$1.webm"
# }

# # Combine all command above
# function ytdl() {
  # local videoName=$(youtube-dl --get-filename $1 | sed 's/\.[^.]*$//')
  # yt-dl $1 && make-mkv "$videoName" && del-file "$videoName" && mkv-to-mp4 "$videoName" && rm "$videoName.mkv"
# }

# # youtube-dl 360p
# function ytdl-360() {
  # local videoName=$(youtube-dl --get-filename $1 | sed 's/\.[^.]*$//')
  # youtube-dl -f '18' $1 && youtube-dl -f '251' $1 && make-mkv "$videoName" && del-file "$videoName" && mkv-to-mp4 "$videoName" && rm "$videoName.mkv"
# }

