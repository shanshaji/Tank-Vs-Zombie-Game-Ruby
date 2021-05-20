module Levels
  include CommonHelperMethods
 private

  (1..10).each do |level|
    define_method "level_#{level}_template" do |*size|
      w, h = size
      walls = []
      spawn_locations = []
      walls << add_borders(w,h)
      walls << generate_walls(level, w, h)
      spawn_locations << generate_spawn_locations(level, w, h)
      spawn_locations.flatten
      walls.flatten
      {
        walls: walls.flatten,
        spawn_locations: spawn_locations.flatten
      } 
    end
  end

  def generate_walls level, w, h
    ordinal_x = 25
    ordinal_y = 20
    (1..(level * 100)).map do |num|

      Wall.new(x: to_cell(ordinal_x), y: to_cell(ordinal_y + num))
    end
  end

  def generate_spawn_locations level, w, h
    (1..level).map do |num|
      SpawnLocation.new(x: rand(w), y: rand(h), rate: 220, countdown: 0, hp: 5)
    end
  end

  def add_borders width, height
    [ 
      Wall.new(x: 0, y: 0, w: width, h: 16),  
      Wall.new(x: 0, y: 0, w: 16, h: height),
      Wall.new(x: 0, y: (height - 16), w: width, h: 16),
      Wall.new(x: (width - 16), y: 0, w: 16, h: height)
    ]
  end
end

