module Levels
 private

    # singleton_class.send(:define_method, "backend") do |*my_arg|
    #     "Born from the ashes!"
    # end

  (1..10).each do |level|
    define_method "level_#{level}_template" do |*size|
      walls = []
      spawn_locations = []
      walls << add_borders(size)
      walls << generate_walls(level)
      spawn_locations << generate_spawn_locations(level)
      spawn_locations.flatten
      walls.flatten
      $gtk.notify! spawn_locations
      {
        walls: walls.flatten,
        spawn_locations: spawn_locations.flatten
      } 
    end
  end

  def generate_walls level
    ordinal_x = 25
    ordinal_y = 20
    (1..(level * 100)).map do |num|

      Wall.new(ordinal_x: ordinal_x, ordinal_y: ordinal_y + num)
    end
    # [
    #   Wall.new(ordinal_x: 25, ordinal_y: 20),
    #   Wall.new(ordinal_x: 25, ordinal_y: 21),
    #   Wall.new(ordinal_x: 25, ordinal_y: 22),
    #   Wall.new(ordinal_x: 25, ordinal_y: 23),
    #   Wall.new(ordinal_x: 26, ordinal_y: 23),
    #   Wall.new(ordinal_x: 27, ordinal_y: 23),
    #   Wall.new(ordinal_x: 28, ordinal_y: 23),
    #   Wall.new(ordinal_x: 29, ordinal_y: 23),
    #   Wall.new(ordinal_x: 30, ordinal_y: 23),
    #   Wall.new(ordinal_x: 31, ordinal_y: 23),
    #   Wall.new(ordinal_x: 32, ordinal_y: 23),
    #   Wall.new(ordinal_x: 33, ordinal_y: 23),
    #   Wall.new(ordinal_x: 34, ordinal_y: 23),
    # ]
  end

  def generate_spawn_locations level
    (1..level).map do |num|
      SpawnLocation.new(ordinal_x: 10, ordinal_y: 10, rate: 120, countdown: 0, hp: 5)
    end
  end

  def add_borders size
    [ 
      Wall.new(ordinal_x: 0, ordinal_y: size[1] - 16, w: size[0], h: 16),
      Wall.new(ordinal_x: 0, ordinal_y: 0, w: size[0], h: 16),
      Wall.new(ordinal_x: 0, ordinal_y: 0, w: 16, h: size[1]),
      Wall.new(ordinal_x: size[0] - 16, ordinal_y: 0, w: 16, h: size[1])
    ]
  end
end