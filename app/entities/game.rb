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
    state.player          ||= Player.new
    state.level           ||= Level.create_level
  end

  def render
    outputs.sprites << level.walls
    outputs.sprites << level.spawn_locations
    outputs.sprites << player.projectiles

    outputs.sprites << level.enemies.map do |e|
      e.merge(path: 'sprites/square/red.png')
    end

    outputs.sprites << player

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
    level.enemies.map! do |e|
      dx =  0
      dx =  1 if e.x < player.x
      dx = -1 if e.x > player.x
      dy =  0
      dy =  1 if e.y < player.y
      dy = -1 if e.y > player.y
      future_e           = future_entity_position dx, dy, e
      future_e_collision = future_collision e, future_e, level.enemies + level.walls
      e.next_x = e.x
      e.next_y = e.y
      e.next_x = future_e_collision.x if !future_e_collision.dx_collision
      e.next_y = future_e_collision.y if !future_e_collision.dy_collision
      e
    end

    level.enemies.map! do |e|
      e.x = e.next_x
      e.y = e.next_y
      e
    end

    level.enemies.each do |e|
      player.damage += 1 if e.intersect_rect? player
    end
  end

  def calc_spawn_locations
    # level.spawn_locations.map! do |s|
    #   s.merge(countdown: s.countdown - 1)
    # end
    level.spawn_locations.each do |s|
      s.countdown -= 1
    end
    level.spawn_locations
         .find_all { |s| s.countdown.neg? }
         .each do |s|
      s.countdown = s.rate
      # s.merge(countdown: s.rate)
      new_enemy = create_enemy s
      if !(level.enemies.find { |e| e.intersect_rect? new_enemy })
        level.enemies << new_enemy
      end
    end
  end

  def create_enemy spawn_location
    {x: spawn_location.x, y: spawn_location.y, hp: 2, w: 16, h: 16}
  end


  def level
    state.level  ||= {}
  end

  def player
    state.player ||={}
  end

  def future_collision entity, future_entity, others
    dx_collision = others.find { |o| o != entity && (o.intersect_rect? future_entity.dx) }
    dy_collision = others.find { |o| o != entity && (o.intersect_rect? future_entity.dy) }

    {
      dx_collision: dx_collision,
      x: future_entity.dx.x,
      dy_collision: dy_collision,
      y: future_entity.dy.y
    }
  end

  def future_entity_position dx, dy, entity
    {
      dx:   entity.merge(x: entity.x + dx),
      dy:   entity.merge(y: entity.y + dy),
      both: entity.merge(x: entity.x + dx, y: entity.y + dy)
    }
  end
end