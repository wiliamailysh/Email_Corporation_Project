require 'rainbow'
require 'io/console'

class Indexer
  def initialize
    #@checker = Done.new
    @surligner = [" ", " ", " ", " ", " ", " "]
  end

  def read_char #Methode trouvee sur Stack OverFlow permet d'avoir les fleches comme input plutot que ZQSD, amelioration non necessaire mais plutot jolie.
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
  ensure
    STDIN.echo = true
    STDIN.cooked!
    return input
  end


  def display
    system 'clear'
    puts "Quel données voulez vous récuperer ?i\n\n"
    puts "      -Quels départements sont concernés ?#{@surligner[0]}"
    puts "      -Comment s'appellent les villes scrappées ?#{@surligner[1]}"
    puts "      -Je veux les emails de chacun !#{@surligner[2]}"
    puts "      -Je veux les twitter de tous !#{@surligner[3]}\n\n"
    puts "Souhaitez vous envoyer des tweets aux mairies ?"
    puts "      -OUI#{@surligner[4]}\n\n"
    puts "Souhaitez vous envoyer des e-mails aux mairies ?"
    puts "      -OUI#{@surligner[5]}\n\n\n\n"
    puts "Utilisez les flêches pour choisir, entree pour valider ou echappe pour quitter."
  end

  def go_around
  i = 0
  j = 0
    while j != 6
      @surligner[i] = " "
      @surligner[j] = Rainbow("<==").red.bright
      display
      "Utilisez les flêches pour choisir"
      input = read_char
      if input == "\e[B" && j < 5
        i = j
        j += 1
      elsif input == "\e[A" && j > 0
        i = j
        j -= 1
      elsif input == "\r"
        @surligner[j] = ' '
        return j
      elsif input == "\e"
        j = 6
        return j
      end
    end
  end
end
