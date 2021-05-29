class Game
  attr_gtk
  include CommonHelperMethods
  attr_reader :player, :camera

  class << self
    def restart
      $gtk.reset
      $game = new
    end
  end
  def initialize
    @width = (100 * 16)
    @height = (100 * 16)
    Level.create_level(w: @width, h: @height)
    @player = Player.new
    @special_powers = []
    @camera = Camera.new(w:@width, h: @height)
    @sprites_to_render = [Level.spawn_locations, @player.projectiles, @player, Level.enemies, Level.walls]
    @game_over = false
    @background_rendered = false
    @clouds = generate_clouds
  end
  def tick
    if state.tick_count >= 50
      render
      input
      calc
    else
      render_screen(640, 360, "Loading...")
    end
    # outputs.debug << args.gtk.framerate_diagnostics_primitives
  end

  def render 
    unless @game_over
      camera.camera_position(@player)
      outputs[:camera].w = camera.w
      outputs[:camera].h = camera.h
      render_background
      outputs[:camera].sprites << @sprites_to_render
      outputs[:camera].static_sprites << @special_powers
      outputs[:camera].static_sprites << @clouds
      outputs.sprites << { x: camera.x,
                          y: camera.y,
                          w: camera.w,
                          h: camera.h, path: camera.path}
      outputs.labels << { x: 30, y: 30.from_top, text: "hp: #{player.hp || 0}" }
    end
  end

  def input
    player.angle = inputs.directional_angle || player.angle
    if inputs.controller_one.key_down.a || inputs.keyboard.key_down.space
      player.attacked_at = state.tick_count
    end
  end

  def calc
    calc_clouds
    calc_walls
    calc_player
    calc_projectiles
    calc_enemies
    calc_spawn_locations
    calc_level
    calc_game
    calc_special
  end

  def calc_special
    if state.tick_count % 900 == 0 && !Level.completed?
      random_x = @width.randomize:ratio
      random_y = @height.randomize:ratio
      @special_powers.shift if @special_powers.length >= 2
      @special_powers << SpecialPower.new(x: random_x, y: random_y)
    end
    @special_powers.each do |special_power|
      special_power.activate(@player, Level.enemies) if @player.picked_special_power? special_power
    end
    @special_powers.delete_if { |special_power| special_power.active == false }
  end

  def calc_clouds
    if state.tick_count % 900 == 0
      @clouds   <<  generate_clouds
    end
    @clouds.flatten.delete_if{|cloud| cloud.outside?(@width, @height)}
  end

  def calc_level
    if Level.completed?
      outputs.labels << { x: 250, y: 290, text: "Press Enter to continue to Level: #{Level.level + 1}" }
      if inputs.keyboard.key_down.enter
        Level + 1
        create_level
        @sprites_to_render = [Level.spawn_locations, player.projectiles, player, Level.enemies, Level.walls]
      end
    end
  end

  def calc_player
    @player.animate(state.tick_count)
    if @player.move?
      @player.future inputs.left_right * @player.speed, inputs.up_down * @player.speed
      unless @player.future_object.intersect_multiple_rect?(Level.walls + Level.spawn_locations)
        @player.move_to_future_position
      end
    end
  end


  def calc_projectiles
    @player.calc_projectiles
    Level.delete_spawns_walls_enemies_if_hit
  end

  def calc_enemies
    Level.activate_enemies_on @player
  end

  def calc_spawn_locations
    Level.activate_spawn_locations
  end

  def calc_walls
    Level.animate_walls
  end

  def calc_game
    @game_over = @player.dead?
    if @game_over
      render_screen(500, 340, "Game Over")
      render_screen(600, 360, "Press Enter to Restart")
      if inputs.keyboard.key_down.enter
        Game.restart
      end
    end
  end

  def create_level
    Level.create_level(w: @width, h: @height)    
  end
end