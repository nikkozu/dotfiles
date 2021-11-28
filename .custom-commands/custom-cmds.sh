#!/bin/bash

# Convert MKV to MP4
function mkv2mp4() {
  local filePath="$1"
  local filename=${filePath%%.*}

  ffmpeg -i "$1" -c:v copy "$filename.mp4"
}

# Make multiple CBZ file
function make-cbz() {
  for file in *; do
    if [[ -d $file ]]; then
      zip -rjq "$file.cbz" "$file"
      echo "- ${file} successfully zipped!!!"
    fi
  done
}

# restart the swap
function restart-swap() {
  sudo swapoff -a && sudo swapon -a
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
  # check if the command match with require commands
  if [[ ! $1 =~ "restart|start|stop|status" ]]; then
    echo 'Please only provide "start", "stop", or "restart" command'
    return;
  fi

  # if command match, start the process from here
  services=("server=(nginx php-fpm7)" "db=(mariadb)" "git=(gitea)")

  for service in "${services[@]}";
  do
    eval $service
  done

  # if [[ $1 -eq "status" ]]; then
    # systemctl status nginx
    # return;
  # fi

  case $2 in
    all)
      for all in "${server[@]}" "${db[@]}" "${git[@]}";
      do
        sudo systemctl $1 $all
      done
      shift
      ;;
    server)
      for server in "${server[@]}";
      do
        sudo systemctl $1 $server
      done
      shift
      ;;
    db)
      for db in "${db[@]}";
      do
        sudo systemctl $1 $db
      done
      shift
      ;;
    git)
      for git in "${git[@]}";
      do
        sudo systemctl $1 gitea
      done
      shift
      ;;
    *)
      ;;
  esac
}

# Github user config
function gituser() {
  git config user.email "masami45@tuta.io"
  git config user.name "Nikkozu"
}

# G++ compile and run
function gpp() {
  local filePath="$1"
  local filename=${filePath%%.*}

  g++ ${filename}.cpp -o ${filename}
  ./${filename}
  rm ${filename}
}

function bdctl() {
  betterdiscordctl -f canary install ; betterdiscordctl -f canary reinstall
}

function get-subdom() {
  curl -v --silent "$1" | grep -Eo '(http|https)://[^/"]+.nhentai.net'
}

function check-cbz() {
  for file in ./**/*.cbz; do
    local checkFile=$(zipinfo "${file}" | grep "^\-" | sed 's/  */ /g' | cut -f4 -d ' ' | grep -x "190")
      if [[ $checkFile ]]; then
        echo "${file} is corrupt"
      fi
  done
}

function touchpad-toggle() {
  if synclient -l | grep "TouchpadOff .*=.*0"; then
    synclient TouchpadOff=1;
  else
    synclient TouchpadOff=0;
  fi
}

#=== Archived functions ===#
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

# function crandr() {
  # if [[ $# -eq 0 ]] ; then
    # crandr start
  # fi

  # for arg in "$@"
  # do
    # case $arg in
      # stop)
        # xrandr --output VGA1 --off
        # shift
        # ;;
      # start)
        # xrandr --newmode "1280x768_60.00"   79.50  1280 1344 1472 1664  768 771 781 798 -hsync +vsync
        # xrandr --addmode VGA1 "1280x768_60.00"
        # xrandr --output LVDS1 --mode 1366x768
        # xrandr --output VGA1 --mode 1280x768_60.00 --right-of LVDS1
        # shift
        # ;;
    # esac
  # done
# }
