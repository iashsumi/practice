# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "test_deploy"

# 指定のディレクトリのシンボルを作成
set :linked_dirs, %w(log)

# デプロイ先の指定
set :deploy_to, "/home/ec2-user/test-deploy"

# 指定のディレクトリのシンボルを作成
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", '.bundle'

namespace :deploy do
  desc 'restart nginx'
  task :nginx_restart do
    on roles(:app) do
      execute "sudo service nginx stop"
      execute "sudo service nginx start"
    end
  end
  
  desc 'Upload database.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
    end
  end

  desc 'Create Database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
      end
      end
    end
  end

  before :starting, :upload
  after  :finished, :nginx_restart
end