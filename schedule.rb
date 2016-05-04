job_type :backup, 'source /root/Backup/.env && cd /root/Backup && backup perform -t :task'

models = Dir[File.join __dir__, 'models', '*.rb']
         .map { |p| File.basename(p, '.rb') }
         .map(&:to_sym)

interval_value = (ENV['BACKUP_INTERVAL_VALUE'] || 1).to_i
interval_unit = ENV['BACKUP_INTERVAL_UNIT'] || 'day'
interval = interval_value.send(interval_unit.to_sym)

every interval do
  models.each { backup model }
end
