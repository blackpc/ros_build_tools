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

function checked_run {
    cecho "┌── $1"
    shift

    $* > /dev/null
    return_value=$?

    if [[ $return_value != 0 ]]; then
        recho "└─╼ Unexpected error"
        exit 1
    else
        gecho "└─╼ Successfuly done"        
    fi
    echo
}

function run {
    cecho "┌── $1"
    redirect_all_output=$2
    shift
    shift
    if [[ $redirect_all_output = 'true' ]]; then
        $* &> /dev/null
    else
        $*
    fi
    gecho "└─╼ Done"
    echo
}

if [[ $# = 0 ]]; then
    cecho "Usage: $0 workspace-name repository-url"
    exit
fi


workspace=~/workspaces/$1
repository=$2

cecho "==============================================================="
cecho "Repository: $repository"
cecho "Workspace : $workspace"
cecho "==============================================================="
cecho "@ Creating catkin workspace..."
echo

checked_run "asd asd" echo 'hello world'

run "Removing workspace if already exitst" true rm $workspace -rf
checked_run "Creating workspace directory..." mkdir $workspace -p

cd $workspace
mkdir src
cd src
checked_run "Initializing workspace..." catkin_init_workspace

cd ..
checked_run "Compiling empty workspace..." catkin_make

run "Sourcing setup.bash..." true source devel/setup.bash

cd src
checked_run "Cloning repository..." git clone $repository

cd ..
checked_run "Building workspace..." catkin_make

checked_run "Installing workspace..." catkin_make install

cecho "@ Done"