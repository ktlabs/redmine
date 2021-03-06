default_run_options[:pty] = true
set :keep_releases, 2

set :application, "redmine"
set :user, "deploy"

set :scm, "git"
set :repository,  "git@github.com:ktlabs/redmine.git"
set :deploy_via, :remote_cache
set :deploy_env, 'production'

role :web, "ktlabs.ru"                          # Your HTTP server, Apache/etc
role :app, "ktlabs.ru"                          # This may be the same as your `Web` server
role :db,  "ktlabs.ru", :primary => true # This is where Rails migrations will run

set :deploy_to, "/var/www/#{application}-production"
set :branch, "master"

after "deploy:symlink", "deploy:copy_custom_files"
after "deploy:symlink", "deploy:migrate"

namespace :deploy do
  task :restart do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Copy custom files"
  task :copy_custom_files, :roles => :db do
    run "cp #{File.join(shared_path,'database.yml')} #{current_path}/config/"
    run "cp #{File.join(shared_path,'session_store.rb')} #{current_path}/config/initializers/"
  end
end

require 'bundler/capistrano'
