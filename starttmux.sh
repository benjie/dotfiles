TMUX="/usr/local/bin/tmux"
if [ "$(echo $($TMUX ls | wc -l))" == "0" ]; then
  echo "Creating new tmux server"
  ~/.tmux-general.sh
  ~/Documents/timecounts-frontend/tmux.sh
else
  echo "Connecting to old tmux"
fi
$TMUX attach-session -t General
