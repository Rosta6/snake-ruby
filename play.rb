require 'rubygems'
require 'bundler/setup'
require 'ruby2d'

require_relative "libs/snake.rb"
require_relative "libs/game.rb"
require_relative "libs/menu.rb"

module SnakeGame
    TEXT_SIZE = 45
    GRID_SIZE = 20
    GRID_WIDTH = Window.width / GRID_SIZE
    GRID_HEIGHT = Window.height / GRID_SIZE
end



# main obrazovka
set background: 'navy'
set height: Window.height + SnakeGame::TEXT_SIZE
#how fast is the snake
set fps_cap: 15

menu = SnakeGame::MainMenu.new
menu.draw_shapes


on :mouse_up do |event|
    # x and y coordinates of the mouse button event
    puts event.x, event.y
  
    # Read the button event
    case event.button
    when :left
      playSnake
    end
  end



def playSnake
    snake = SnakeGame::Snake.new
    game = SnakeGame::Game.new
    # tady běží samotná hra
    update do
        clear
        unless game.finished?
            snake.move
        end
        snake.draw
        game.draw
        if game.snake_hit_cube?(snake.x, snake.y)
            game.record_hit
            game.new_cube(snake.positions)
            snake.grow      
        end

        if snake.hit_itself?
            game.finish
        end
    end
    #read key from keyboard
    on :key_down do |event|
        if['up','down','left','right'].include?(event.key)
            if snake.can_change_direction_to?(event.key)
                snake.direction = event.key
            end
        elsif event.key == "r"
            snake = SnakeGame::Snake.new
            game = SnakeGame::Game.new
        end
    end
end

show

