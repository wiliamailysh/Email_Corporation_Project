require 'twitter'
require 'dotenv'
require 'json'
Dotenv.load('./.gitignore/.env')

class TwitterBot
  def initialize(do?=0)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['KEY_ID_API']
      config.consumer_secret     = ENV['KEY_ID_SECRET_API']
      config.access_token        = ENV['TOKEN_ACCESS_ID']
      config.access_token_secret = ENV['TOKEN_ACCESS_SECRET_ID']
    end
    get_townhall_handle
    if do? < 0
      follow_townhall
    end
  end

  def get_townhall_handle
    gnagna
      begin
        townhall_handle = @client.user_search("Ville de #{town}").first.screen_name
      rescue NoMethodError => e
        begin
          townhall_handle = @client.user_search("Mairie de #{town}").first.screen_name
        rescue NoMethodError => e
          townhall_handle = "Cette mairie n'as pas de compte twitter"
        end
      end
    puts townhall_handle
  end

  def follow_townhall
    
      @client.follow(townhall_handle)
    end
  end

end

TwitterBot.new
