require './lib/view/index.rb'
require './lib/view/done.rb'
require './lib/app/townhalls_follower.rb'
require './lib/app/townhalls_scrapper.rb'
require './lib/app/townhalls_adder_to_db.rb'
require './lib/app/townhalls_mailer.rb'
require 'json'
require 'twitter'
require 'dotenv'
require 'Rainbow'
require 'nokogiri'
require 'open-uri'
require 'gmail'

class App
  def initialize
    @scrap = Scrapper.new
    @index = Indexer.new
    puts "Pour commencer le recueil de données, appuyez sur n'importe quelle touche"
    STDIN.getch
    AdderDatabase.new(@scrap.perform)
    perform
  end

  def indexing
    while j != 6
      j = @index.go_around
      if j == 0
        system 'clear'
        puts " Les départements concernés sont le Var, le Vaucluse et l'Hérault\n\n\n"
        puts "Pour continuer, appuyez sur n'importe quelle touche"
        STDIN.getch
      elsif j == 1
        file = File.read("./db/townhalls.json")
        hash = JSON.parse(file)
        hash.each do |hasher|
          puts hasher['Ville']
        end
      elsif j == 2
        file = File.read("./db/townhalls.json")
        hash = JSON.read(file)
        hash.each do |hasher|
          puts "L'email de la mairie de #{hasher['Ville']} est #{hasher['Mails']}"
        end
      elsif j == 3
        hash = Twitter.new(0)
        AdderDatabase.new(hash)
      elsif j == 4
        Twitter.new(2)
      elsif j == 5
        Mailer.new
      end
    end
  end
  def perform
    indexing
    puts "Au revoir !"
  end
end


App.new
