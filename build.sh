#!/bin/bash

if [[ $# = 0 ]]; then
    echo "Usage: $0 workspace-name repository-url"
    exit
fi

workspace=/home/cogni/workspaces/$1
repository=$2

echo "===================================================="
echo "Repository: $repository"
echo "Workspace : $workspace"
echo "===================================================="
echo "@ Creating catkin workspace..."
echo " - Creating workspace directory..."
mkdir workspace -p
echo " - Initializing workspace..."
cd $workspace
mkdir src
cd src
catkin_init_workspace
echo " - Compiling empty workspace..."
cd ..
catkin_make
echo " - Sourcing setup.bash..."
source devel/setup.bash
echo " - Cloning repository..."
cd src
git clone $repository
cd ..
echo " - Building workspace..."
catkin_make
echo " - Installing workspace..."
catkin_make install
echo "@ Done"




