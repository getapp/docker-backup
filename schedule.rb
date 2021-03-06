# pass all env vars to cron job
ENV.each { |(k, v)| env k, v }

set :output, '/var/log/cron.log'
set :path, '/root/Backup'
set :job_template, ':job'

job_type :backup, 'cd :path && backup perform -t :task :output'

models = Dir[File.join __dir__, 'models', '*.rb']
         .map { |p| File.basename(p, '.rb') }
         .map(&:to_sym)

every ENV['BACKUP_INTERVAL'] do
  models.each { |m| backup m }
end
