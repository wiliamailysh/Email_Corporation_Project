require 'json'
require 'nokogiri'
require 'open-uri'
require 'pp'

class Scrapper 

    attr_accessor :name_town, :mail_town, :dept_numbr, :container, :url_town
    
    def initialize
        @name_town = []
        @mail_town = []
        @dept_numbr = []
        @url_town = []
        @container = []
        @dept = ["martinique", "guadeloupe"]
        # @dept = ["var", "herault", "vaucluse"]
    end

    def get_url_dept(department)
        Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{department}.html"))
    end

    def get_url_town
        @dept.each do |dept|
            page = get_url_dept(dept)
            page.css('a.lientxt').each do |link|
                href = link['href'].slice(1..-1)
                href = "http://annuaire-des-mairies.com#{href}"
                @url_town << href
            end
        end
    end

    def get_name
        @dept.each do |dept|
            page = get_url_dept(dept)
            page.css('a.lientxt').each do |link|
                @name_town << link.text
                puts link.text
            end
        end
    end

    def get_mail
        @url_town.each do |link|
            page = Nokogiri::HTML(open("#{link}"))
            this_mail = page.css("body > div > main > section:nth-child(2) > div > table > tbody > tr:nth-child(4) > td:nth-child(2)")
            this_mail = this_mail.text
            if this_mail == ""
                this_mail = "MAIL ABSENT"
            end
            @mail_town << this_mail
            puts this_mail
        end
    end

    def get_numbr
        @dept.each do |dept|
            page = get_url_dept(dept)
            page.css('a.lientxt').each do |link|
                @dept_numbr << link['href'].slice(2..3)
                puts link['href'].slice(2..3)
            end
        end
    end

    def create_hash 
        @name_town.each.with_index do |x, i|
            this_town = Hash.new
            this_town['Ville'] = @name_town[i]
            this_town['Mail'] = @mail_town[i]
            this_town['Département'] = @dept_numbr[i]
            this_town['Handle'] = " "
            @container << this_town
        end
        pp @container
    end

    def write_json
        # File.open("../db/townhalls.JSON", "w") do |this|
        #     this.write(@container.to_json)
        # end
        @container.each do |hash|
            File.open("townhalls.json","w") do |f|
                f.write(hash.to_json)
            end
        end
    end

    

    def perform
        get_url_town
        get_mail
        get_name
        get_numbr
        create_hash
        write_json
        
    end
end

tt = Scrapper.new
tt.perform

# File.write("../db/townhalls.JSON", @container.to_json)

