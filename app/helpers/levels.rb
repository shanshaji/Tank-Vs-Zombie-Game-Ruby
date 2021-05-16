module Levels
 private

 def level_1_template
    {
      walls:           [Wall.new(ordinal_x: 25, ordinal_y: 20),
                        Wall.new(ordinal_x: 25, ordinal_y: 21),
                        Wall.new(ordinal_x: 25, ordinal_y: 22),
                        Wall.new(ordinal_x: 25, ordinal_y: 23)],
      spawn_locations: [SpawnLocation.new(ordinal_x: 10, ordinal_y: 10, rate: 120, countdown: 0, hp: 5)]
    }
  end
# ,{ ordinal_x: 10, ordinal_y: 10, rate: 120, countdown: 0, hp: 5 }
  def level_2_template
    {
      walls:           [Wall.new(ordinal_x: 25, ordinal_y: 20),
                        Wall.new(ordinal_x: 25, ordinal_y: 23)],
      spawn_locations: [{ ordinal_x: 10, ordinal_y: 10, rate: 120, countdown: 0, hp: 10 }]
    }
  end
end