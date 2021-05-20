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
    state.player           ||= Player.new
    # state.width ||= (200 * 16)
    # state.height ||= (200 * 16)
    state.level            ||= Level.create_level(w:(200 * 16), h: (200*16))
    state.sprites_to_render||= [level.walls, level.spawn_locations, player.projectiles, level.enemies, player]
  end

  def render
    outputs[:camera].w = level.width
    outputs[:camera].h = level.height
    outputs[:camera].sprites << state.sprites_to_render
    outputs.sprites << { x: camera_position.x,
                        y: camera_position.y,
                        w: outputs[:camera].w,
                        h: outputs[:camera].h, path: :camera }
    outputs.labels << { x: 30, y: 30.from_top, text: "damage: #{player.damage || 0}" }
  end

  def input
    player.angle = inputs.directional_angle || player.angle
    if inputs.controller_one.key_down.a || inputs.keyboard.key_down.space
      player.attacked_at = state.tick_count
    end
  end

  def calc
    calc_player
    calc_projectiles
    calc_enemies
    calc_spawn_locations
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
  end

  def calc_enemies
    level.enemies.each do |e|
      e.attack player
      others = level.enemies + level.walls
      e.x = e.future_position[:dx].x unless e.intersect_future_position?(others, :dx)
      e.y = e.future_position[:dy].y unless e.intersect_future_position?(others, :dy)
      player.damage += 1 if e.intersect_rect? player
    end
  end

  def calc_spawn_locations
    level.spawn_locations.each(&:start_countdown)
    level.spawn_locations
         .find_all { |s| s.countdown.neg? }
         .each do |s|
      s.countdown = s.rate
      new_enemy = Enemy.new(x: s.x, y: s.y, hp: 2)
      future_enemy = FutureObject.new(new_enemy.x, new_enemy.y, new_enemy.w, new_enemy.h)
      unless future_enemy.intersect_multiple_rect?(level.enemies)
        level.enemies << new_enemy
      end
    end
  end

  def level
    state.level  ||= {}
  end

  def player
    state.player ||={}
  end
end