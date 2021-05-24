class Game
  attr_gtk
  include CommonHelperMethods
  def tick
    defaults
    render
    input
    calc
  end

  def defaults
    state.width ||= (100 * 16)
    state.height ||= (100 * 16)
    state.player           ||= Player.new
    state.camera           ||= Camera.new(w:state.width, h: state.height)
    state.level            ||= create_level
    state.sprites_to_render||= [level.walls, level.spawn_locations, player.projectiles, level.enemies, player]
    state.clouds   ||=  generate_clouds
  end

  def render
    camera.camera_position(player)
    outputs[:camera].w = camera.w
    outputs[:camera].h = camera.h
    render_background
    outputs[:camera].sprites << state.sprites_to_render
    outputs[:camera].static_sprites << state.clouds
    outputs.sprites << { x: camera.x,
                        y: camera.y,
                        w: camera.w,
                        h: camera.h, path: camera.path}
    outputs.labels << { x: 30, y: 30.from_top, text: "hp: #{player.hp || 0}" }
  end

  def input
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
    if args.state.tick_count % 900 == 0
      state.clouds   <<  generate_clouds
    end
    state.clouds.flatten.delete_if{|cloud| cloud.outside?(state.width, state.height)}
  end

  def calc_level
    if level.enemies.empty? && level.spawn_locations.empty?
      outputs.labels << { x: 250, y: 290, text: "Press Enter to continue to Level: #{Level.level + 1}" }
      if inputs.keyboard.key_down.enter
        Level + 1
        state.level = create_level
        state.sprites_to_render = [level.walls, level.spawn_locations, player.projectiles, level.enemies, player]
      end
    end
  end

  def calc_player
    player.animate(state.tick_count)
    if player.attacked_at.elapsed_time > 5
      future_player_new = player.future_player_position_new inputs.left_right * 2, inputs.up_down * 2
      unless future_player_new.intersect_multiple_rect?(level.walls)
        player.x = future_player_new.x
        player.y = future_player_new.y
      end
    end
  end


  def calc_projectiles
    player.projectiles.each do |projectile|
      projectile.move
      projectile.calc_projectile_collisions level.walls + level.enemies + level.spawn_locations
    end
    player.projectiles.delete_if { |p| p.is_not_active? }
    level.enemies.delete_if { |enemy|  enemy.dead? }
    level.spawn_locations.delete_if{ |spawn_location| spawn_location.destroyed? }
    level.walls.delete_if{ |wall| wall.destroyed? }
  end

  def calc_enemies
    level.enemies.each do |enemy|
      others = level.enemies + level.walls
      enemy.animate player, others
    end
  end

  def calc_spawn_locations
    level.spawn_locations.each(&:start_countdown)
    level.spawn_locations
         .find_all { |s| s.countdown.neg? }
         .each do |s|
      s.countdown = s.rate
      new_enemy = Enemy.new(x: s.x, y: s.y, hp: s.enemy_hp, power: s.enemy_power)
      unless new_enemy.intersect_multiple_rect?(level.enemies)
        level.enemies << new_enemy
      end
    end
  end

  def create_level
    Level.create_level(w: state.width, h: state.height)
  end

  def level
    state.level
  end

  def player
    state.player
  end

  def camera
    state.camera
  end
end