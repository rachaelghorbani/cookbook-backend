Cloudinary.config do |config|    
    config.cloud_name = ENV["CLOUD_NAME"]   
    config.api_key = ENV["CLOUD_KEY"]   
    config.api_secret = ENV["CLOUD_SECRET"]  
    config.secure = true    
    config.cdn_subdomain = true  
 end