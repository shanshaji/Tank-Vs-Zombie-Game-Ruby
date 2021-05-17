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
    state.level            ||= Level.create_level
    state.sprites_to_render||= [level.walls, level.spawn_locations, player.projectiles, level.enemies, player]  
  end

  def render
    outputs.sprites << state.sprites_to_render
    # outputs.sprites << level.walls
    # outputs.sprites << level.spawn_locations
    # outputs.sprites << player.projectiles

    # outputs.sprites << level.enemies

    # outputs.sprites << player

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

  def calc_projectile_collisions entities
    entities.each do |e|
      e.damage ||= 0
      player.projectiles.each do |p|
        if !p.collided && (p.intersect_rect? e)
          p.collided = true
          e.damage  += 1
        end
      end
    end
  end

  def calc_projectiles
    player.projectiles.each do |projectile|
      projectile.move
    end

    calc_projectile_collisions level.walls + level.enemies + level.spawn_locations
    player.projectiles.reject! { |p| p.at.elapsed_time > 10000 }
    player.projectiles.reject! { |p| p.collided }
    level.enemies.reject! { |e| e.damage > e.hp }
    level.spawn_locations.reject! { |s| s.damage > s.hp }
  end

  def calc_enemies
    level.enemies.each do |e|
      e.attack player
      # future_enemy_position = e.attack player
      # state.future ||= future_enemy
      # $gtk.notify! future_enemy
      # unless future_enemy.intersect_multiple_rect?(level.enemies + level.walls)
      #   e.x = future_enemy.x
      #   e.y = future_enemy.y
      # end
      # args.state.future_enemy_position = future_enemy_position
      others = level.enemies + level.walls
      e.x = e.future_position[:dx].x unless e.intersect_future_position?(others, :dx)
      e.y = e.future_position[:dy].y unless e.intersect_future_position?(others, :dy)
      player.damage += 1 if e.intersect_rect? player
    end
    # level.enemies.each do |e|
    #   player.damage += 1 if e.intersect_rect? player
    # end
  end

  def calc_spawn_locations
    level.spawn_locations.each do |s|
      s.countdown -= 1
    end
    level.spawn_locations
         .find_all { |s| s.countdown.neg? }
         .each do |s|
      s.countdown = s.rate
      # new_enemy = create_enemy s
      new_enemy = Enemy.new(x: s.x, y: s.y, hp: 2)
      future_enemy = FutureObject.new(new_enemy.x, new_enemy.y, new_enemy.w, new_enemy.h)
      unless future_enemy.intersect_multiple_rect?(level.enemies)
        level.enemies << new_enemy
      end
    end
  end

  def create_enemy spawn_location
    Enemy.new(x: spawn_location.x, y: spawn_location.y, hp: 2)
  end


  def level
    state.level  ||= {}
  end

  def player
    state.player ||={}
  end
end