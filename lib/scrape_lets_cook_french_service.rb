require "open-uri"
require "nokogiri"
require_relative "recipe"
require "pry-byebug"

class ScrapeLetsCookFrenchService # or ScrapeMarmitonService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{@keyword}"
    # 3. Parse HTML
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    # 4. For the first five results
    results = []
    html_doc.search('.m_contenu_resultat')[0...5].each do |element|
      name_details = element.search('.m_titre_resultat')
      name = name_details.text.strip
      description = element.search('.m_texte_resultat').text.strip
      prep_time = element.search('.m_prep_time').first.parent.text.strip
      # difficulty = element.search(".m_detail_recette").text.strip.split('-')[2].strip
      results << Recipe.new(name: name, description: description, prep_time: prep_time, difficulty: difficulty)
    end
    return results
  end
end
