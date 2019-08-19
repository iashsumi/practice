require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'
 
CarrierWave.configure do |config|
  config.storage :fog
  config.cache_storage = :fog
  config.asset_host = 'http://localhost:9000/mybucket'
  config.fog_provider = 'fog/aws'
  config.fog_directory  = 'mybucket'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'minio_access_key',
    aws_secret_access_key: 'minio_secret_key',
    path_style: true,
    region: 'ap-northeast-1',
    host: 'minio',  
    endpoint: 'http://minio:9000'
  }
end
 
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/