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
    if do? <= 1
      get_townhall_handle
    end
    if do? >= 1
      follow_townhall
    end
  end

  def get_townhall_handle
    f = File.open("../.././db/townhalls.json")
    hash = JSON.read(f)
    hash.each do |town|
      begin
        townhall_handle = @client.user_search("Ville de #{town['Ville']}").first.screen_name
      rescue NoMethodError => e
        begin
          townhall_handle = @client.user_search("Mairie de #{town['Ville']}").first.screen_name
        rescue NoMethodError => e
          townhall_handle = "Cette mairie n'as pas de compte twitter."
          town['Mail'] = townhall_handle
        end
      end
      if townhall_handle != "Cette mairie n'as pas de compte twitter."
        town['Handle'] = "@#{townhall_handle}"
      end
    end
    return hash
  end

  def follow_townhall
    f = File.open("../.././db/townhalls.json")
    hash = JSON.read(f)
    hash.each do |town|
      if town['Mail'] != "Cette mairie n'as pas de compte twitter."
        @client.follow(town['Handle'].sub("@", "")
      end
    end
  end

end

TwitterBot.new
