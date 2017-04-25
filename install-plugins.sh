#!/bin/bash
echo -ne "\nDoing initial setup\n "

JENKINS_PLUGINS_URL=https://updates.jenkins-ci.org/latest/
JENKINS_PLUGINS_DIR=$JENKINS_HOME/plugins

# Create plugins directory if it doesn't exist
mkdir -p $JENKINS_PLUGINS_DIR

while read p; do
  wget -c -r -l0 --no-directories --ignore-case -A "$p.*" $JENKINS_PLUGINS_URL -P "$JENKINS_HOME/plugins"
done < plugins.txt
