FROM centos:latest

MAINTAINER techolution.com

ARG java_rpm=jdk-8u112-linux-x64.rpm

ADD rpm/${java_rpm} /${java_rpm}
ADD tools /tools

RUN rpm -ivh ${java_rpm} && \
    rm -fv ${java_rpm}
	
ARG user=jenkins
ARG grp=jenkins
ARG jen_home=/opt/jenkins
ARG jen_rpm=jenkins-2.19.4-1.1.noarch.rpm

ADD start-jenkins.sh /start-jenkins.sh
ADD rpm/${jen_rpm} /${jen_rpm}
ADD plugins.txt /plugins.txt
ADD install-plugins.sh /install-plugins.sh

RUN groupadd -r ${grp} && useradd -s /bin/bash -r -m ${user} -p saPEBZUoWBIjs -g ${grp} && \
    chown ${user} /start-jenkins.sh && chmod 755 /start-jenkins.sh && \
    chown ${user} /install-plugins.sh && chmod 755 /install-plugins.sh && \
    yum install -y wget git && \
    rpm -Uvh /${jen_rpm} && rm -fv /${jen_rpm} &&\

    yum clean all

RUN /install-plugins.sh

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

# for ajp13:
EXPOSE 8009

USER ${user}
# Jenkins home directory is a volume, that keeps configuration and build history 
# can be persisted and survive image upgrades
VOLUME ${jen_home}

ENV JENKINS_HOME ${jen_home}
CMD ["/start-jenkins.sh"]
