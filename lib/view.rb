class View
  def display(recipes)
    puts '______________COOKBOOK______________'
    recipes.each_with_index do |recipe, index|
      done = recipe.done? ? "[X]" : "[ ]"
      puts "#{index + 1}. #{recipe.name} - #{recipe.prep_time} - #{recipe.description} - #{done}"
    end
  end

  def ask_user_for_(stuff)
    puts "What is the #{stuff} ?"
    print ">"
    gets.chomp
  end

  def ask_user_for_index
    puts "What is the recipe index?"
    print ">"
    gets.chomp.to_i - 1
  end


end
