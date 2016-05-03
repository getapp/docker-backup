FROM ruby:2.2

MAINTAINER Boris Mikhaylov

# install backup and cron gems
RUN gem install backup whenever

RUN apt-get update \
    && apt-get install -y cron \
    && apt-get autoremove -y -qq \
    && apt-get clean -qq

RUN backup generate:config

ADD entrypoint.sh /opt/
ONBUILD ADD schedule.rb /root/Backup/
ONBUILD ADD models /root/Backup/models/
ONBUILD ADD jobs.rb /root/Backup/

WORKDIR /root/Backup

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["cron", "-f"]
