FROM ubuntu:14.04
MAINTAINER gfjardims <gfjardim@gmail.com>

# Add the JAVA repository, import it's key and accept it's license
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 select true" | sudo /usr/bin/debconf-set-selections

RUN apt-get update -qq && \
    apt-get install -qq --force-yes grep sed cpio gzip oracle-java7-installer supervisor && \
    apt-get autoremove && \
    apt-get autoclean

RUN usermod -u 99 nobody && \
    usermod -g 100 nobody

ADD files/ /opt/
RUN bash /opt/crashplan-install.sh && \
    chmod 777 /opt/CrashPlan.sh && \
    mkdir -p /var/lib/crashplan && \
    chown -R nobody /usr/local/crashplan /var/lib/crashplan

VOLUME /data

EXPOSE 4243
EXPOSE 4242

CMD ["supervisord", "-c", "/opt/supervisor.conf", "-n"]
