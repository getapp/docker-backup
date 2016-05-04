FROM ruby:2.2

MAINTAINER Boris Mikhaylov

RUN apt-get update \
    && apt-get install -y cron \
    && apt-get autoremove -y -qq \
    && apt-get clean -qq

# symlink bundler to avoid problems with cron scripts		
 RUN ln -fs /usr/local/bundle/bin/bundle /usr/bin/bundle

WORKDIR /root/Backup
ADD Gemfile /root/Backup/
ADD Gemfile.lock /root/Backup/
RUN bundle install
RUN backup generate:config

ADD entrypoint.sh /opt/
ADD schedule.rb /root/Backup/

ONBUILD ADD models /root/Backup/models/

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["cron", "-f"]
