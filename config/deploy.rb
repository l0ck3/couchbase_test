require "rvm/capistrano"
require "bundler/capistrano"
require "cape"

set :deploy_to, "/home/deployer/alerti-test"
set :deploy_via, :copy
set :copy_remote_dir, "#{shared_path}/tmp"
set :copy_strategy, :export
set :repository,  "git@bitbucket.org:wengee-tek/alerti-test.git"
set :rvm_ruby_string, "2.0.0-p195@alerti-test"
set :use_sudo, false
# set :deploy_via, :remote_cache

set :user, "deployer"
role :web, "82.196.4.238"
role :app, "82.196.4.238"
role :db,  "82.196.4.238", :primary => true

after "deploy:restart", "deploy:cleanup"
after "deploy", "rvm:trust_rvmrc"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

Cape do
  mirror_rake_tasks :dev
end
