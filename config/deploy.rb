set :application, 'mugen'
set :repo_url, 'git@github.com:causztic/mugen.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :branch, "master"

set :use_sudo, false
set :bundle_binstubs, nil
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :rvm_type, :user # :user if RVM installed in $HOME

before 'deploy', 'rvm1:alias:create'
after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:legacy_restart'
  end
end