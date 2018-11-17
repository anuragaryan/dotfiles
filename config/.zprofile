tmux has -t scratch &> /dev/null

if [ $? != 0 ]; then
  tmux -2 new-session -s scratch -D -d
fi

if [ -z "$TMUX" ]; then
  tmux attach -t scratch -d
fi

alias note="vim +'normal Go' +'r!date' ~/note.txt"
