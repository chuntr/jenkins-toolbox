#!/bin/bash
# @author Christopher Hunter <christopher.hunter@bigfishgames.com>
# @copyright 2016

# usage:
#    cd ${JENKINS_HOME}/jobs/
#    "get_usage.sh $JOBNAME"

# Typically this would be looped in the job dir and output to a log. i.e:
#    for x in `ls`; do ~/get_usage.sh "$x" >> ~/${LOGFILE}; done;
# find may work better if you have a lot of directory names with spaces:
#    find ./ -maxdepth 1 -type d -print0 | xargs -0 -I {} ~/get_usage.sh {} >> ~/${LOGFILE}

size=$( du -sh "${1}" )
count=$( ls "${1}/builds/" | wc -l )

# Print the output out in nice columns:
#   $C=1 : number of stored builds
#   $C=2 : total space used
#   $C=3 : job directory name
# The directory name is conveniently also output by du, so we nicely get 3
# columns of data when we've only done two calculations.
echo "${count} ${size}" | awk '{printf "%6d %5s %s", $1,$2,$3"\n"}'

# Cat the output log through 'sort -h -k $C' to sort based on columns
# and find your worst offenders
#    cat ${LOGFILE} | sort -k ${C} -h
