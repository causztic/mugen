# Change these
server '128.199.193.0', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:causztic/mugen.git'
set :application,     'mugen'
set :user,            'graf'
# set :puma_threads,    [4, 16]
# set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
# set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
# set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
# set :puma_access_log, "#{release_path}/log/puma.error.log"
# set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
# set :puma_preload_app, true
# set :puma_worker_timeout, nil
# set :puma_init_active_record, true  # Change to false when not using ActiveRecord
set :unicorn_pid,        "/var/run/unicorn.pid"
set :unicorn_config_path, "/etc/unicorn.conf"

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
set :log_level,       :info
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml .env}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc "Use envs"
  task :set_env do
    on roles(:app) do
      Capistrano::Env.use do |env|
        env.add 'APP_DATABASE_PASSWORD'
        env.formatter = :dotenv #=> default is :ruby, but it is deprecated now.
        env.filemode = 0644 #=> default is 0640.
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'unicorn:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# unicorn master -D -c /etc/unicorn.conf -E production 