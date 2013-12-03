#!/bin/bash

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
catkin_make
cecho " - Sourcing setup.bash..."
source devel/setup.bash
cecho " - Cloning repository..."
cd src
git clone $repository
cd ..
cecho " - Building workspace..."
catkin_make
cecho " - Installing workspace..."
catkin_make install
cecho "@ Done"