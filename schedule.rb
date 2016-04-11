job_type :backup, 'source /Backup/.env && cd /Backup && backup perform -t :task'

every 1.day do
  backup :mongo
  backup :mysql
end
