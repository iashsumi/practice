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

  after  :finished, :nginx_restart
end