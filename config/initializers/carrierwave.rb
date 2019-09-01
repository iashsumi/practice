require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'
 
CarrierWave.configure do |config|
  # storage, cache_storageはfog(外部サービス指定)
  config.storage :fog
  config.cache_storage = :fog
  case Rails.env
  when 'production'
    config.fog_public = false 
    config.fog_directory = 'mybucket-tlog-test'
    config.fog_credentials = {
      provider: 'AWS',
      use_iam_profile: true,
      path_style: true,
      region: 'ap-northeast-1'
    }
  when 'development'
    # ブラウザから参照する際のパスを指定(http://ドメイン/バケット名)
    config.asset_host = 'http://localhost:9000/mybucket'
    # バケット名
    config.fog_directory = 'mybucket'
    # 認証情報
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'minio_access_key',
      aws_secret_access_key: 'minio_secret_key',
      path_style: true,
      region: 'ap-northeast-1',
      host: 'minio',  
      endpoint: 'http://minio:9000'
    }
  when 'test'
    config.storage :file
    config.cache_storage = :file
  end
end
# ファイル名に日本語を許可
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/