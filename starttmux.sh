TMUX="/usr/local/bin/tmux"
if [ "$(echo $($TMUX ls | wc -l))" == "0" ]; then
  echo "Creating new tmux server"
  #~/.tmux-general.sh
  ~/Documents/HookHaven/.tmux.sh
else
  echo "Connecting to old tmux"
fi
$TMUX -CC attach-session -t BOTS
