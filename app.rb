require './lib/views/index.rb'
require './lib/views/done.rb'
require './lib/app/townhalls_follower.rb'
require './lib/app/townhalls_scrapper.rb'
require './lib/app/townhalls_adder_to_db.rb'
require './lib/app/townhalls_mailer.rb'
require 'json'
require 'twitter'
require 'dotenv'
require 'rainbow'
require 'nokogiri'
require 'open-uri'
require 'gmail'
Dotenv.load('./.gitignore/.env')

class App
  def initialize
    @scrap = Scrapper.new
    @index = Indexer.new
    puts "Pour commencer le recueil de données, appuyez sur n'importe quelle touche"
    STDIN.getch
    #AdderDatabase.new(@scrap.perform)
    perform
  end

  def indexing
    j= 0
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
        puts "\n\nAppuyez sur n'importe quelle touche pour continuer"
        STDIN.getch
      elsif j == 2
        file = File.read("./db/townhalls.json")
        hash = JSON.parse(file)
        hash.each do |hasher|
          puts "L'email de la mairie de #{hasher['Ville']} est #{hasher['Mail']}"
        end
        puts "\n\nAppuyez sur nimporte quelle touche pour continuer"
        STDIN.getch
      elsif j == 3
        file = File.read("./db/townhalls.json")
        hash = JSON.parse(file)
        hash = TwitterBot.new(hash, 2)
        hash.each do |hasher|
         puts "En ce qui concerne la ville de #{hasher['Ville']} :    #{hasher['Handle']}"
        end
        AdderDatabase.new(hash, 1)
      elsif j == 4
        file = File.read("./db/townhalls.json")
        hash = JSON.parse(file)
        Twitter.new(hash, 2)
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
