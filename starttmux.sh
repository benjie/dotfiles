TMUX="/usr/local/bin/tmux"
$TMUX ls
if [ "$?" == "0" ]; then
  echo "Connecting to old tmux"
else
  echo "Creating new tmux server"
  ~/.tmux-general.sh
  ~/Documents/timecounts-frontend/tmux.sh
fi
$TMUX attach-session -t General
