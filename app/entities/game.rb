class Game
  attr_gtk
  include CommonHelperMethods
  attr_reader :player, :camera
  def initialize
    @width = (100 * 16)
    @height = (100 * 16)
    Level.create_level(w: @width, h: @height)
    @player = Player.new
    @camera = Camera.new(w:@width, h: @height)
    # @clouds = generate_clouds
    @sprites_to_render||= [Level.spawn_locations, player.projectiles, Level.enemies, player, Level.walls]
  end
  def tick
    defaults
    render
    input
    calc
    outputs.debug << args.gtk.framerate_diagnostics_primitives
  end

  def defaults
    state.clouds   ||=  generate_clouds
  end

  def render
    camera.camera_position(player)
    outputs[:camera].w = camera.w
    outputs[:camera].h = camera.h
    render_background
    outputs[:camera].sprites << @sprites_to_render
    outputs[:camera].static_sprites << state.clouds
    outputs.sprites << { x: camera.x,
                        y: camera.y,
                        w: camera.w,
                        h: camera.h, path: camera.path}
    outputs.labels << { x: 30, y: 30.from_top, text: "hp: #{player.hp || 0}" }
  end

  def input
    # $gtk.notify! inputs.directional_angle
    player.angle = inputs.directional_angle || player.angle
    if inputs.controller_one.key_down.a || inputs.keyboard.key_down.space
      player.attacked_at = state.tick_count
    end
  end

  def calc
    calc_clouds
    calc_player
    calc_projectiles
    calc_enemies
    calc_spawn_locations
    calc_level
  end

  def calc_clouds
    if state.tick_count % 900 == 0
      state.clouds   <<  generate_clouds
    end
    state.clouds.flatten.delete_if{|cloud| cloud.outside?(@width, @height)}
  end

  def calc_level
    if Level.enemies.empty? && Level.spawn_locations.empty?
      outputs.labels << { x: 250, y: 290, text: "Press Enter to continue to Level: #{Level.level + 1}" }
      if inputs.keyboard.key_down.enter
        Level + 1
        create_level
        @sprites_to_render = [Level.walls, Level.spawn_locations, player.projectiles, Level.enemies, player]
      end
    end
  end

  def calc_player
    player.animate(state.tick_count)
    if player.move?
      player.future inputs.left_right * 2, inputs.up_down * 2
      unless player.future_object.intersect_multiple_rect?(Level.walls)
        player.move_to_future_position
      end
    end
  end


  def calc_projectiles
    player.calc_projectiles
    Level.delete_spawns_walls_enemies_if_hit
  end

  def calc_enemies
    Level.activate_enemies_on player
  end

  def calc_spawn_locations
    Level.activate_spawn_locations
  end

  def create_level
    Level.create_level(w: @width, h: @height)    
  end
end