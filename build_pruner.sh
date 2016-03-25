#!/bin/bash
# @author Christopher Hunter <christopher.hunter@bigfishgames.com>
# @copyright 2016

# For cleaning up old, unused builds from jenkins jobs. This
# will delete a range of numeric symlinks (between $1 and $2),
# and the corresponding build directory for each one.

# usage:
#    cd ${JENKINS_HOME}/jobs/${JOBNAME}/builds/
#    "bulid_pruner.sh $1 $2"

for x in `seq $1 $2`; do
    # a) get the name of the symlink target
    f=$( ls -l $x | sed -re 's/(.* ->)(.*)/\2/' );
    # b) remove the actual folder
    sudo -u tomcat rm -rf $f;
    # c) remove the (now broken) symlink to the folder
    sudo -u tomcat rm $x;
done;
