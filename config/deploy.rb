require 'dotenv'
Dotenv.load '.env'
# Change these
server '128.199.193.0', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:causztic/mugen.git'
set :application,     'mugen'
set :user,            'graf'
set :conditionally_migrate, true
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :default_env, {
  'APP_DATABASE_PASSWORD' => ENV['APP_DATABASE_PASSWORD']
}
## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w{.env}
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
        env.add 'SECRET_KEY_BASE', ENV['SECRET_KEY_BASE']
        env.formatter = :dotenv #=> default is :ruby, but it is deprecated now.
        env.filemode = 0644 #=> default is 0640.
      end
    end
  end

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:reload'
  end

  before :starting,     :check_revision
  before :starting,     :set_env
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# unicorn master -D -c /etc/unicorn.conf -E production 