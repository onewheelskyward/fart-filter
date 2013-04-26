set :application, "fart-filter"
set :repository,  "git@github.com:onewheelskyward/fart-filter"
set :deploy_via,	:remote_cache
set :normalize_asset_timestamps, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "pucksteak"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

namespace :fartfilter do
	task :bundle_install do
		run "cd /u/apps/#{fetch(:application)}/current ; ~/.rbenv/shims/bundle install ; ~/.rbenv/bin/rbenv rehash"
	end
	task :unicorn_restart do
		run "kill -s USR2 `cat /u/apps/fart-filter/shared/pids/unicorn.pid`"
	end
end
# if you want to clean up old releases on each deploy uncomment this:
after "deploy:create_symlink", "fartfilter:bundle_install"
after "deploy:create_symlink", "fartfilter:unicorn_restart"

#after "deploy:restart", "deploy:cleanup"

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
