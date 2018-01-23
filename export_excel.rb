require "google_drive"
#Gem disponible ici : https://github.com/gimite/google-drive-ruby
require_relative "scrapping.rb"

#Export vers GoogleDrive

# Creates a session. This will prompt the credential via command line for the
# first time and save it to config.json file for later usages.
# See this document to learn how to create config.json:
# https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
session = GoogleDrive::Session.from_config("config.json")


# Worksheet link
$ws = session.spreadsheet_by_key("1lJysVv-SEzN4_EJl3lRBNRmJeXiYHp7VBmfuqceRsAk").worksheets[0]

def export
  $ws[1, 1] = "Liste des villes"
  $ws[1, 2] = "Liste des urls"
  i=2
  $Hash_mix.each { |key,value|
    $ws[i,1] = key
    $ws[i,2] = value
    i +=1
  }

  $ws.save
end
print export
