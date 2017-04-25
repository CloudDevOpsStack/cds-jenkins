#!/bin/bash
echo "2.0" > "$JENKINS_HOME/jenkins.install.InstallUtil.lastExecVersion"

/usr/bin/java -Dcom.sun.akuma.Daemon=daemonized \
              -Djava.awt.headless=true \
              -Djava.net.preferIPv4Stack=true \
              -DJENKINS_HOME="$JENKINS_HOME" \
              -jar /usr/lib/jenkins/jenkins.war \
              --logfile=/var/log/jenkins/jenkins.log \
              --webroot=/var/cache/jenkins/war \
              --daemon \
              --httpPort=8080 \
              --httpListenAddress=0.0.0.0 \
              --debug=5 \
              --handlerCountMax=100 \
              --handlerCountMaxIdle=20 \
              --accessLoggerClassName=winstone.accesslog.SimpleAccessLogger \
              --simpleAccessLogger.format=combined \
              --simpleAccessLogger.file=/var/log/jenkins/access_log
