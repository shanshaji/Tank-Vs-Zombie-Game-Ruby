require "app/helpers/common_helper_methods.rb"
require "app/helpers/levels.rb"
require "app/helpers/background.rb"
require "app/constants/constants.rb"
require "app/entities/sprite.rb"
require "app/entities/animated_sprite.rb"
require "app/entities/special_power.rb"
require "app/entities/spawn_location.rb"
require "app/entities/future_object.rb"
require "app/entities/wall.rb"
require "app/entities/cloud.rb"
require "app/entities/level.rb"
require "app/entities/projectile.rb"
require "app/entities/player.rb"
require "app/entities/enemy.rb"
require "app/entities/camera.rb"
require "app/entities/game.rb"

def tick args
  $game ||= Game.new
  $game.args = args
  $game.tick
end

$gtk.reset
$game = nil
