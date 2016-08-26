uri = URI.parse(ENV["REDISTOGO_URL"]) rescue nil
REDIS = Redis.new(:url => uri)
Redis::Objects.redis = REDIS
