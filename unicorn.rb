dir = File.expand_path(File.dirname(__FILE__))

worker_processes 1
working_directory dir

timeout 30

# Specify path to socket unicorn listens to,
# # we will use this in our nginx.conf later
listen "#{dir}/tmp/pids/unicorn.sock", :backlog => 64
listen 8080
#
# # Set process id path
pid "#{dir}/tmp/pids/unicorn.pid"
#
# # Set log file paths
stderr_path "#{dir}/log/unicorn.stderr.log"
stdout_path "#{dir}/log/unicorn.stdout.log"
