default_run_options[:pty] = true

set :application, "redmine"

set :scm, "git"
set :repository,  "git@github.com:ktlabs/redmine.git"
set :deploy_via, :remote_cache
set :deploy_env, 'production'

role :web, "ktlabs.ru"                          # Your HTTP server, Apache/etc
role :app, "ktlabs.ru"                          # This may be the same as your `Web` server
role :db,  "ktlabs.ru", :primary => true # This is where Rails migrations will run

set :deploy_to, "/var/www/#{application}-production"
set :branch, "master"

after "deploy:symlink", "deploy:copy_db_config"

namespace :deploy do
  task :restart do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end

  desc "Copy database config"
  task :copy_db_config, :roles => :db do
    run "#{try_sudo} cp #{File.join(shared_path,'database.yml')} #{current_path}/config/"
  end
end

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end