set :port, 22
set :user, 'pi'
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production"
set :unicorn_env, "production"
set :bundle_env_variables, { 'NOKOGIRI_USE_SYSTEM_LIBRARIES' => 1 }

server '192.168.1.207',
  roles: [:web, :app],
  port: fetch(:port),
  user: fetch(:user),
  port: fetch(:port),
  primary: true

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  user: fetch(:user)
}