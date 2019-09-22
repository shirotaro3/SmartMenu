require "refile/s3"

aws = {
  access_key_id: Rails.application.credentials.s3[:access_key],
  secret_access_key: Rails.application.credentials.s3[:secret_key],
  region: "ap-northeast-1",
  bucket: "s3-smart-menu",
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
