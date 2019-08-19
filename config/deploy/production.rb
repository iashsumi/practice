# 環境指定
set :rails_env, 'production'
 
# サーバー、ユーザー、ロールの指定
server "ec2-18-179-46-223.ap-northeast-1.compute.amazonaws.com", user: "ec2-user", roles: %w{app db web}
 
# デプロイ先のリポジトリ指定(/home/ec2-user/test-deploy.git)
set :repo_url, "/home/ec2-user/test-deploy.git"
 
# デプロイするブランチ指定
set :branch, 'master'
 
# 環境変数の指定
set :default_env, {
  test: "test_data",
  RAILS_MASTER_KEY: "00bd821e1e716acbdcfcc2de6614a848"
}
 
# SSHの設定
set :ssh_options, {
  keys: %w(./key/env-test-tlog.pem),
  forward_agent: false
}