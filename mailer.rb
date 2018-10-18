require 'gmail'
require 'dotenv'
require 'json'

Dotenv.load

gmail = Gmail.connect(ENV['mail'], ENV['password'])

file = file.read("../db/townhalls.json")

JSON.parse(file).each do |name| 
  string_mails = string_mails + "#{name['Mails']}, "
end 

  string_mails = string_mails.chomp(", ")

gmail.deliver do
  to string_mails
  subject "Decouvrez THP"
  html_part do
    content_type 'text/html; charset=UTF-8'
    body "<p>Bonjour,</p>

<p>Alexandre, Hava, Maxime, Victor sommes &eacute;l&egrave;ves &agrave; The Hacking Project, une formation au code gratuite, sans locaux, sans s&eacute;lection, sans restriction g&eacute;ographique. La p&eacute;dagogie de notre &eacute;cole est celle du peer-learning, o&ugrave; nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident &agrave; faire de The Hacking Project un nouveau format d'&eacute;ducation pour tous.</p>

<p>D&eacute;j&agrave; 500 personnes sont pass&eacute;es par The Hacking Project. Est-ce votre mairie veut changer le monde avec nous ?</p>

<p>Charles, co-fondateur de The Hacking Project pourra r&eacute;pondre &agrave; toutes vos questions : 06.95.46.60.80</p>"
  end

gmail.logout

end