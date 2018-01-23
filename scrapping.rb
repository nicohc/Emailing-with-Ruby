require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

#Route de la mairie

  def get_the_email_of_a_townhall_from_its_webpage(url_ville)
    ville = ville.to_s
    #page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/94/#{ville}.html"))
    page = Nokogiri::HTML(open(url_ville))
    email = page.css('td[class=style27] p:contains("@")').text
    return email
  end
  #get_the_email_of_a_townhall_from_its_webpage("vaureal")


  def get_all_the_urls_of_vdm_townhalls
    page2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-de-marne.html"))
    listurl_brut = page2.css('.lientxt')                #permet d'obtenir tout le code brut après le <a>
    listurl = listurl_brut.map{ |link| link['href']  }    #permet d'obtenir la valeur du href
#p listurl.class
    urls = listurl.map! { |lien| "http://annuaire-des-mairies.com"+ lien.slice!(1..lien.length)}
    return urls
#p urls.class
    #compile pour chaque résulat le début de l'url avec les fins d'url obtenues
    #le slice permet de retirer le "." au début de chaque fin d'url
  end

#p get_all_the_urls_of_vdm_townhalls

  def get_all_the_emails
    liste_emails = get_all_the_urls_of_vdm_townhalls.map{ |url_ville|
    get_the_email_of_a_townhall_from_its_webpage(url_ville)
  }
  end

#p get_all_the_emails.class

  def get_name_of_vdm_townhalls
    page2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-de-marne.html"))
    listname_brut = page2.css('.lientxt').map { |name_brut| name_brut.text.capitalize }
    return listname_brut
  end

p noms_villes = get_name_of_vdm_townhalls
p liste_mails = get_all_the_emails

$Hash_mix = Hash[noms_villes.zip(liste_mails.map{|i| i.include?(',') ? (i.split /, /) : i})]
#p mix
