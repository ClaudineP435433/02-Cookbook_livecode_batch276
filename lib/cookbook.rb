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

  def find(index)
    @recipes[index]
  end

  def mark_as_done(index)
    #trouve la recette
    recipe = @recipes[index]
    #recette mark as done
    recipe.mark_as_done!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:done] = (row[:done] == "true" ? true : false)

      # row[:done] = row[:done] == "true"
      # if row[:done] == "true"
      #   true
      # else
      #   false
      # end

      # {} can be removed to create a recipe
      #   recipe = Recipe.new({name: row[0], description: row[1], prep_time: row[2]})
      #   recipe = Recipe.new(name: row[:name], description: row[:description], prep_time: row[:prep_time], done: row[:done])
      recipe = Recipe.new(row)
      @recipes << recipe
    end
  end

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"', headers: :first_row }

    CSV.open(@csv_file_path , 'wb', csv_options) do |csv|
      csv << ["name","description","prep_time", "done", "difficulty"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done?, recipe.difficulty ]
      end
    end
  end

end
