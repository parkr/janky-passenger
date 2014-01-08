set :application, "janky"
set :repository,  "git://github.com/parkr/janky-passenger.git"
set :deploy_to,   "/var/www/#{application}"

set :linked_files, %w{.env}

set :scm, :git

abort "Please set your CAP_DEPLOY_HOST variable before running `cap deploy`." unless ENV.has_key?('CAP_DEPLOY_HOST')
role :web, ENV['CAP_DEPLOY_HOST']
role :app, ENV['CAP_DEPLOY_HOST']
role :db,  ENV['CAP_DEPLOY_HOST']

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :deploy do
  task :symlink_shared do
    run "ln -s #{shared_path}/.env #{release_path}/"
  end
end

before "deploy:restart", "deploy:symlink_shared"
