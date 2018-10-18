require 'gmail'
require 'dotenv'
require 'json'

#On lance Dotenv qui masquera les informations sensibles en allant les chercher dans .env
   Dotenv.load

   class Mailer

      def initialize
#Connexion à Gmail
        gmail = Gmail.connect(ENV['mail'], ENV['password'])

#On va chercher le Json (noms et adresses mails des communes, numéros des départements)
        file = file.read("../db/townhalls.json")

#On crée une string qui ne contendra que les adresses mails des communes
        JSON.parse(file).each do |name| 
  string_mails = string_mails + "#{name['Mails']}, "
        end 

#On retire le dernier ", "
  string_mails = string_mails.chomp(", ")

#Envoi des mails
gmail.deliver do
#Destinataires
  to string_mails
  subject "Decouvrez THP"
#Partie HTML du mail
  html_part do
    content_type 'text/html; charset=UTF-8'
    body "<p>Bonjour,</p>

<p>Alexandre, Hava, Maxime, Victor et Corentin sommes &eacute;l&egrave;ves &agrave; The Hacking Project, une formation au code gratuite, sans locaux, sans s&eacute;lection, sans restriction g&eacute;ographique. La p&eacute;dagogie de notre &eacute;cole est celle du peer-learning, o&ugrave; nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident &agrave; faire de The Hacking Project un nouveau format d'&eacute;ducation pour tous.</p>

<p>D&eacute;j&agrave; 500 personnes sont pass&eacute;es par The Hacking Project. Est-ce votre mairie veut changer le monde avec nous ?</p>

<p>Charles, co-fondateur de The Hacking Project pourra r&eacute;pondre &agrave; toutes vos questions : 06.95.46.60.80</p>"


#Déconnexion
gmail.logout
      end
end
