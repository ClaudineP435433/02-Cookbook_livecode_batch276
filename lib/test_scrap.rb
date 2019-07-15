require 'open-uri'
require 'nokogiri'
require_relative 'recipe'

ingredient = 'chocolate'
url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}"

html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

recipes_scrapped = []

html_doc.search('.m_resultats_recherche').each do |element|
  name = element.search('.m_titre_resultat').text.strip
  description = element.search('.m_texte_resultat').text.strip
  # # p link = element.search('.m_titre_resultat a').attribute('href').value
  recipe = Recipe.new(name, description)
  recipes_scrapped << recipe
end

# # recipes_scrapped << recipe


recipes_scrapped
