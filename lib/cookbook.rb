# initialize(csv_file_path) which loads existing Recipe from the CSV
# all which returns all the recipes
# add_recipe(recipe) which adds a new recipe to the cookbook
# remove_recipe(recipe_index) which removes a recipe from the cookbook.
require 'csv'
require_relative 'recipe.rb'


class Cookbook

  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end


  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      # Here, row is an array of columns
      recipe = Recipe.new(row[0], row[1])
      @recipes << recipe
    end
  end

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file_path , 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end

end
