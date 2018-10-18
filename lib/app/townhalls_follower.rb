require 'twitter'
require 'dotenv'
require 'json'

class TwitterBot
  def initialize(did, l)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['KEY_ID_API']
      config.consumer_secret     = ENV['KEY_ID_SECRET_API']
      config.access_token        = ENV['TOKEN_ACCESS_ID']
      config.access_token_secret = ENV['TOKEN_ACCESS_SECRET_ID']
    end
    if l == 2
      get_townhall_handle(did)
    else
      follow_townhall(did)
    end
  end

  def get_townhall_handle(ville)
    begin
      ville.each_with_index do |town, i|
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
      rescue 
      if townhall_handle != "Cette mairie n'as pas de compte twitter."
        ville[i]['Handle'] = "@#{townhall_handle}"
      end
      puts "...LOADING - PLEASE WAIT..."
      end
    rescue Twitter::Error::TooManyRequests => e
      return ville
    end
    return ville
  end

  def follow_townhall(ville)
    ville.each do |town|
      if town['Mail'] != "Cette mairie n'as pas de compte twitter."
        @client.follow(town['Handle'].sub("@", ""))
      end
    end
  end

end
