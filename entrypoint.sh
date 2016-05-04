#!/bin/bash

# Do this so we can read these vars in cron
set > /root/Backup/.env

whenever -f /root/Backup/schedule.rb --clear-crontab
whenever -f /root/Backup/schedule.rb --write-crontab

exec $@
