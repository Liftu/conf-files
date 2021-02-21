#!/bin/sh

# First add this line to the sudoers file
# user	ALL=(root) NOPASSWD: /usr/sbin/openvpn *-release.ovpn

# Set Session Name
SESSION="HTB"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

# Only create tmux session if it doesn't already exist
if [ -z "$SESSIONEXISTS" ]
then
    # Start New Session with our name
    tmux new-session -d -s $SESSION

    # Name first Pane and start OpenVPN
    tmux rename-window -t $SESSION 'OpenVPN'
    tmux send-keys -t $SESSION:'OpenVPN' 'sudo openvpn `ls *release.ovpn -1 | head -n 1`' C-m

    # Start a new window with 2 panes and select the first pane
    tmux new-window -t $SESSION -n 'Main'
    tmux split-window -t $SESSION:'Main' -h # Horizontal split
    tmux select-window -t $SESSION:'Main'
    tmux select-pane -t $SESSION:'Main' -t 0

fi

# Attach Session, on the Main window
tmux attach-session -t $SESSION
