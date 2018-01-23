require 'gmail'
# Gem disponible sur : https://github.com/gmailgem/gmail
require "google_drive"
# Gem disponible ici : https://github.com/gimite/google-drive-ruby
require 'dotenv'
Dotenv.load

session = GoogleDrive::Session.from_config("config.json")
$ws = session.spreadsheet_by_key("1MsyRmejHfj2XvQDU4OKZ9ySA5patlgoPS4DlVFfYcJ4").worksheets[0]

username  = ENV["USRNM"]
password  = ENV["PSSWRD"]

$gmail = Gmail.connect(username, password)
p $gmail.logged_in?

#On définit la matrice des destinataire
$destinataire = []

#On crée la fonction permettant d'inclure les emails dans la matrice Destinataires
def include_emails
  i = 1
  until i > $ws.num_rows do
    $destinataire << $ws[i,2] #On ajoute chaque ligne du tableau dans la matrice
    i +=1
  end
end
include_emails

def send_email_to_list
    $destinataire.each { |chr|
      $gmail.deliver do  #On envoie à chaque personne de la matrice Destinataires
        to "#{chr}"
        subject "Having fun in Los Angeles !"
        text_part { body "Text of plaintext message." }
        html_part {
          content_type 'text/html; charset=UTF-8'
          body "<p>Les rois du code.</p>
                <br><img src='http://www.replygif.net/i/937.gif' height='400px'>
                <br>Si vous avez reçu ce mail, cela veut dire que ce code fonctionne et que vous pouvez le retrouver à l'adresse suivante :
                <br><a href='https://github.com/nicohc/Emaliling-with-Ruby.git'>https://github.com/nicohc/Emaliling-with-Ruby.git</a>"
      }
      end
      p "Envoyé à #{chr}"
    }
end
send_email_to_list


#print "Nombre de mails non lus :"
#p gmail.inbox.count(:unread)

$gmail.logout
