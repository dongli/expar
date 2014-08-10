worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
timeout 300

working_directory "#{ENV['APP_ROOT']}"

listen "#{ENV['APP_ROOT']}/tmp/sockets/unicorn.socket", backlog: 64
listen 3000 if not ENV.has_key?('WEB_NOT_LISTEN_ON_3000_PORT')

pid "#{ENV['APP_ROOT']}/tmp/pids/unicorn.pid"
stderr_path "#{ENV['APP_ROOT']}/log/unicorn.stderr.log"
stdout_path "#{ENV['APP_ROOT']}/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
