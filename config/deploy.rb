require "bundler/capistrano"
require 'sidekiq/capistrano'

server "ec2-54-183-105-129.us-west-1.compute.amazonaws.com", :web, :app, :db, primary: true

set :application, "demo"
set :user, "ubuntu"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:Cong-Thanh/#{application.capitalize}.git"
set :branch, "master"

default_run_options[:pty] = true
set :ssh_options, {:forward_agent => true}
set :ssh_options, {:auth_methods => "publickey"}
set :ssh_options, {:keys => ["/Users/thanh/code/Demo/ThanhNguyen.pem"]}

after "deploy", "deploy:cleanup" # keep only the last 5 releases

set(:sidekiq_cmd) { "bundle exec sidekiq" }
set(:sidekiq_role) { :app }

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/application.example.yml"), "#{shared_path}/config/application.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
  
  desc "Run Nodejs"
  task :run_nodejs, roles: :web do
    run "cd #{current_path} && npm install"
    run "cd #{current_path} && node_modules/coffee-script/bin/coffee server.coffee"
  end
  after "deploy:restart", "deploy:run_nodejs"

  namespace :assets do
    desc "Precompile assets on local machine and upload them to the server."
    task :precompile, roles: :web, except: {no_release: true} do
      run_locally "bundle exec rake RAILS_ENV=production assets:clean"
      run_locally "bundle exec rake RAILS_ENV=production assets:precompile"
      find_servers_for_task(current_task).each do |server|
        run_locally 'rsync -vr --exclude=".DS_Store" -e "ssh -i /Users/thanh/code/Demo/ThanhNguyen.pem" public/assets #{user}@#{server.host}:#{shared_path}/'
      end
    end
  end
end