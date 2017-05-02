FROM centos:latest
MAINTAINER techolution.com

ARG user=jenkins
ARG grp=jenkins
ARG jen_home=/opt/jenkins

ADD start-jenkins.sh /start-jenkins.sh
ADD plugins.txt /plugins.txt
ADD install-plugins.sh /install-plugins.sh

RUN groupadd -r ${grp} && useradd -s /bin/bash -r -m ${user} -p saPEBZUoWBIjs -g ${grp} && \
    chown ${user} /start-jenkins.sh && chmod 755 /start-jenkins.sh && \
    chown ${user} /install-plugins.sh && chmod 755 /install-plugins.sh && \
    yum install -y wget git java java-devel && \
    yum clean all


#RUN sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
#RUN sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN wget -O /jenkins-2.46.2-1.1.noarch.rpm https://pkg.jenkins.io/redhat-stable/jenkins-2.46.2-1.1.noarch.rpm
RUN rpm -Uvh /jenkins-2.46.2-1.1.noarch.rpm && rm -fv /jenkins-2.46.2-1.1.noarch.rpm

RUN /install-plugins.sh

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

# for ajp13:
EXPOSE 8009

RUN chown jenkins. /opt/jenkins -R

USER ${user}
# Jenkins home directory is a volume, that keeps configuration and build history 
# can be persisted and survive image upgrades
VOLUME ${jen_home}

ENV JENKINS_HOME ${jen_home}
CMD ["/start-jenkins.sh"]
