class Recipe

  attr_reader :name, :description, :prep_time, :difficulty

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false
    @difficulty = difficulty || "?"
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end

end
