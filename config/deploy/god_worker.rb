begin
APP_NAME = 'socialgrowth'
BASE_DIR = "/mnt/www/#{APP_NAME}"
PID_PATH = "#{BASE_DIR}/shared/pids"
God.pid_file_directory = PID_PATH

begin

God.watch do |w|
  pid_file = PID_PATH + "/socialgrowth.pid"
  w.name = "socialgrowth"
  w.start = "bundle exec rake campaign:start --trace"
  w.dir = BASE_DIR + '/current/webapp'
  w.log = BASE_DIR + '/shared/log/socialgrowth.log'
  w.env = {"RAILS_ENV" => ENV['RAILS_ENV'],
           "PIDFILE" => pid_file}
  w.stop          = -> { `kill -s KILL #{IO.read(pid_file)}` }
  w.start_grace   = 5.seconds
  w.restart_grace = 5.seconds
  w.keepalive#(:memory_max => 150.megabytes, :cpu_max => 50.percent)
end
