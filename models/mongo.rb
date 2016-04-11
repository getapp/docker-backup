Model.new(:my_backup, 'My Backup') do
  database MongoDB do |db|
    db.name               = ENV['MONGO_DATABASE']
    db.username           = ENV['MONGO_USER']
    db.password           = ENV['MONGO_PASS']
    db.host               = ENV['MONGO_HOST']
    db.port               = ENV['MONGO_PORT']
    db.ipv6               = false
    db.only_collections   = [ENV['MONGO_COLLECTION']]
    db.lock               = false
    db.oplog              = false
  end

  store_with S3 do |s3|
    s3.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    s3.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    s3.region = ENV['AWS_REGION']
    s3.bucket = ENV['AWS_BUCKET']
    s3.path = ENV['AWS_MONGO_PATH']
  end
end
