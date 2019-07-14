require_relative 'cookbook'    # You need to create this file!

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)

p cookbook
