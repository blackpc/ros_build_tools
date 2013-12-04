#!/bin/bash

function recho {
    echo -e '\E[37;41m'"\033[1m$1\033[0m"
}

function gecho {
    echo -e '\E[37;42m'"\033[1m$1\033[0m"
}

function cecho {
    echo -e '\E[37;44m'"\033[1m$1\033[0m"
}

if [[ $# = 0 ]]; then
    cecho "Usage: $0 workspace-name repository-url"
    exit
fi

workspace=/home/cogni/workspaces/$1
repository=$2

cecho "===================================================="
cecho "Repository: $repository"
cecho "Workspace : $workspace"
cecho "===================================================="
cecho "@ Creating catkin workspace..."
rm $workspace -rf
cecho " - Creating workspace directory..."
mkdir $workspace -p
cecho " - Initializing workspace..."
cd $workspace
mkdir src
cd src
catkin_init_workspace
cecho " - Compiling empty workspace..."
cd ..
catkin_make > /dev/null && (gecho " - Successfuly done") || (recho " - Unexpected error" && exit)
cecho " - Sourcing setup.bash..."
source devel/setup.bash
cecho " - Cloning repository..."
cd src
git clone $repository > /dev/null
cd ..
cecho " - Building workspace..."
catkin_make > /dev/null && (gecho " - Successfuly done") || (recho " - Unexpected error" && exit)
cecho " - Installing workspace..."
catkin_make install > /dev/null && (gecho " - Successfuly done") || (recho " - Unexpected error" && exit)
cecho "@ Done"