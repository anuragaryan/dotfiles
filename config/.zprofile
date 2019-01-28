tmux has -t scratch &> /dev/null

if [ $? != 0 ]; then
  tmux -2 new-session -s scratch -D -d
fi

if [ -z "$TMUX" ]; then
  tmux attach -t scratch -d
fi

# alias note="vim +'normal Go' +'r!date' ~/note.txt"

# HOWTO USE: `note` opens the file `note.md`, `note topic` opens the file `topic_note.md` and
# `note sync` syncs the note to github
function note() {
  if [ "$1" = sync ]; then
    cd ~/notes/
    git add .
    git commit -m "Syncs note on: `date`"
    git push -u origin master
    cd -
    echo "Sync files to github."
  elif [ -n "$1" ]; then # args is present
    vim +'normal Go' +'0r!date' +'r~/notes/header.md' ~/notes/$1_note.md
  else
    vim +'normal Go' +'0r!date' +'r~/notes/header.md' ~/notes/note.md
  fi # closing statement of if-else block
}
