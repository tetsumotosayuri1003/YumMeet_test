CarrierWave.configure do |config|
    if Rails.env.development?
      config.storage = :file
      config.enable_procession = false if Rails.env.test?
    elsif Rails.env.production?
      config.cache_dir = "#{Rails.root}/tmp/uploads"
      config.storage = :fog
      config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
        aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
        region: 'ap-northeast-1'
      }
      config.fog_directory = 'YumMeet' if Rails.env.production?
      config.fog_public = false
      config.fog_authenticated_url_expiration = 60
    end
  end
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
