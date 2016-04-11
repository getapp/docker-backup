FROM ruby:2.2

MAINTAINER Boris Mikhaylov

# install backup and cron gems
RUN gem install backup whenever

# add mongodb repository
RUN \
    apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && \
    echo "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen" | tee /etc/apt/sources.list.d/mongodb.list

RUN apt-get update \
    && apt-get install -y cron mysql-client mongodb-org-tools \
    && apt-get autoremove -y -qq \
    && apt-get clean -qq

RUN backup generate:config

ADD start.sh /opt/
ADD schedule.rb /Backup/

WORKDIR /Backup

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["cron", "-f"]
