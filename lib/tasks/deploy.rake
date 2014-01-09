namespace :deploy do
  # Put tasks that need to be done at deploy time here
  task :all => ['deploy:setup', 'deploy:worker', 'deploy:web'] do
    true
  end

  task :setup => ['db:seed'] do
    true
  end

  task :web => ['assets:precompile'] do
    true
  end

  task :worker => [] do
    true
  end

end
