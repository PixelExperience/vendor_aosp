#!/bin/sh

cmd=$(git log --oneline --after=$After_Date --until=$Until_Date)
repo_url=$(git config --get "remote.$(echo $REPO_REMOTE).url") ;

if [ ! -z "$cmd" ]; then
    echo -e "* Repository: ${repo_url}/commits/${REPO_RREV}\n\n${cmd}\n"
fi
