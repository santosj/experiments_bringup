#!/bin/bash

SESSION=$USER

tmux -2 new-session -d -s $SESSION
# Setup a window for tailing log files
tmux new-window -t $SESSION:0 -n 'roscore'
tmux new-window -t $SESSION:1 -n 'mongodb'
tmux new-window -t $SESSION:2 -n 'simulation'
tmux new-window -t $SESSION:3 -n '2d_nav'
tmux new-window -t $SESSION:4 -n 'navigation'
tmux new-window -t $SESSION:5 -n 'scheduler'
tmux new-window -t $SESSION:6 -n 'run_scheculer'
tmux new-window -t $SESSION:7 -n 'ptu_metric'
tmux new-window -t $SESSION:8 -n 'meta_rooms'
tmux new-window -t $SESSION:9 -n 'exploration'
tmux new-window -t $SESSION:10 -n 'services'
tmux new-window -t $SESSION:11 -n 'soma_query'
tmux new-window -t $SESSION:12 -n 'soma_map'

tmux select-window -t $SESSION:0
tmux split-window -v
tmux select-pane -t 0
tmux send-keys "roscore" C-m
tmux resize-pane -U 30
tmux select-pane -t 1
tmux send-keys "htop" C-m

tmux select-window -t $SESSION:1
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 roslaunch mongodb_store mongodb_store.launch db_path:=$HOME/mongodb_store"

tmux select-window -t $SESSION:2
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 roslaunch strands_morse tsc_morse.launch"

tmux select-window -t $SESSION:3
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 roslaunch strands_morse tsc_nav2d.launch"

tmux select-window -t $SESSION:4
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 roslaunch strands_morse tsc_navigation.launch"

tmux select-window -t $SESSION:5
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 roslaunch task_executor mdp-executor.launch "

tmux select-window -t $SESSION:6
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 echo 'rosservice call /task_executor/set_execution_status "status: true"'"

tmux select-window -t $SESSION:7
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 roslaunch scitos_ptu ptu_action_server_metric_map.launch"

tmux select-window -t $SESSION:8
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 roslaunch semantic_map_launcher semantic_map.launch"

tmux select-window -t $SESSION:9
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 roslaunch spatiotemporal_exploration spatiotemporal_exploration.launch"

tmux select-window -t $SESSION:10
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 "

tmux select-window -t $SESSION:11
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 rosrun soma_manager soma_query_manager_node somadata object somadata roi"

tmux select-window -t $SESSION:11
tmux send-keys "source ~/object_ws/devel/setup.bash; DISPLAY=:0 rosrun soma_map_manager soma_map_manager_node.py --mapname tsc.yaml"

# Set default window
tmux select-window -t $SESSION:0

# Attach to session
tmux -2 attach-session -t $SESSION

tmux setw -g mode-mouse off
