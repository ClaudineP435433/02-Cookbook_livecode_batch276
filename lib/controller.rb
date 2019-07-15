# initialize(cookbook) takes an instance of the Cookbook as an argument.
# list all the recipes
# create a new recipe
# destroy an existing recipe

require_relative 'view.rb'
require 'open-uri'
require 'nokogiri'
require_relative 'scrape_lets_cook_french_service'


class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    #Aller dans view demander les infos
    name = @view.ask_user_for_("name")
    description = @view.ask_user_for_("description")
    prep_time = @view.ask_user_for_("temps de préparation")
    #Créer une instance
    recipe = Recipe.new(name: name, prep_time: prep_time, description: description )
    #Stocker mon instance
    @cookbook.add_recipe(recipe)
  end

  def destroy
    #Afficher la liste
    display_recipes
    #demander l'index
    recipe_index = @view.ask_user_for_index
    #supprimer la recette
    @cookbook.destroy(recipe_index)
  end

  def import
    #Demander ce qu'il cherche
    ingredient = @view.ask_user_for_("ingredient you are looking for")
    recipes_scrapped = ScrapeLetsCookFrenchService.new(ingredient).call
    #Lister les 5 premieres recettes
    @view.display(recipes_scrapped)
    #Choix de l'utilisateur
    index = @view.ask_user_for_index
    recipe = recipes_scrapped[index]
    #Ajout dans le cookbook et dans le csv
    @cookbook.add_recipe(recipe)
    #Afficher la liste
    display_recipes
  end

  def mark_as_done
    #list des recettes
    display_recipes
    #index ?
    index = @view.ask_user_for_index
    # enregistre
    @cookbook.mark_as_done(index)
  end


  private

  def display_recipes
    #trouver les recettes
    recipes = @cookbook.all
    #afficher mes recettes
    @view.display(recipes)
  end

end
