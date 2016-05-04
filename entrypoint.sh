#!/bin/bash

whenever -f /root/Backup/schedule.rb --write-crontab

exec $@
