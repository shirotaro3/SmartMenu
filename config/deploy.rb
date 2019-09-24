# config valid for current version and patch releases of Capistrano
lock "~> 3.11.1"

set :application, "SmartMenu"
set :repo_url, "git@github.com:shirotaro3/SmartMenu.git"

# Default branch is :master
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/SmartMenu"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push("config/settings.yml",'config/master.key')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system")

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# 保持するバージョンの個数(※後述)
set :keep_releases, 5

# rubyのバージョン
set :rbenv_ruby, '2.5.5'

#出力するログのレベル。
set :log_level, :debug

namespace :deploy do
    desc "Make sure local git is in sync with remote."
    task :confirm do
      on roles(:app) do
        puts "This stage is '#{fetch(:stage)}'. Deploying branch is '#{fetch(:branch)}'."
        puts 'Are you sure? [y/n]'
        ask :answer, 'n'
        if fetch(:answer) != 'y'
          puts 'deploy stopped'
          exit
        end
      end
    end
  
    desc "Initial Deploy"
    task :initial do
      on roles(:app) do
        before 'deploy:restart', 'puma:start'
        invoke 'deploy'
      end
    end
  
    desc "Restart Application"
    task :restart do
      on roles(:app), in: :sequence, wait: 5 do
        invoke 'puma:restart'
      end
    end
  
    before :starting, :confirm
  end