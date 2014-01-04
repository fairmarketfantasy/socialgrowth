task :start_all_campaigns, [:wait_time] => :environment do |t, args|
  File.open(ENV['PIDFILE'], 'w') { |f| f << Process.pid } if ENV['PIDFILE']
  wait_time = 60
  unless args.wait_time.nil?
    wait_time = Integer(args.wait_time)
  end
  puts "Updating campaigns every #{wait_time} seconds"
  while true
    puts "#{Time.now} -- spamming campaign candidates"
    Campaign.spam
    sleep wait_time
  end
end