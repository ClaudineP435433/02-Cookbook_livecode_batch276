# initialize(cookbook) takes an instance of the Cookbook as an argument.
# list all the recipes
# create a new recipe
# destroy an existing recipe

require_relative 'view.rb'

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
    #Créer une instance
    recipe = Recipe.new(name, description)
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

  private

  def display_recipes
    #trouver les recettes
    recipes = @cookbook.all
    #afficher mes recettes
    @view.display(recipes)
  end

end
