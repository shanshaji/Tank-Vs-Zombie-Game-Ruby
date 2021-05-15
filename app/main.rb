require "app/helpers/common_helper_methods.rb"
require "app/helpers/levels.rb"
require "app/entities/level.rb"
require "app/entities/player.rb"
require "app/entities/game.rb"

def tick args
  $game ||= Game.new
  $game.args = args
  $game.tick
end

$gtk.reset
$game = nil
