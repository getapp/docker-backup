job_type :backup, 'source /root/Backup/.env && cd /root/Backup && backup perform -t :task'

models = Dir[File.join __dir__, 'models', '*.rb']
         .map { |p| File.basename(p, '.rb') }
         .map(&:to_sym)

every ENV['BACKUP_INTERVAL'] do
  models.each { |m| backup m }
end
