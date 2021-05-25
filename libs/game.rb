module SnakeGame
    class Game
        def initialize
            @score = 0
            @cube_x = rand(GRID_WIDTH)
            @cube_y = rand(GRID_HEIGHT)
            @finished = false
        end

        def draw
            unless finished?
                Square.new(x: @cube_x * GRID_SIZE, y: @cube_y * GRID_SIZE + TEXT_SIZE, size: GRID_SIZE , color: 'red')
            end
            Text.new(text_message_left, color: 'green', x: GRID_WIDTH * GRID_SIZE - 115, y: 10, size: 25, z: 1)
            Text.new(text_message_right, color: 'green', x: 10, y: 10, size: 25, z: 1)
            Rectangle.new(x: 0, y: 0, width: Window.width, height: TEXT_SIZE, color: 'blue', z: 0) # rectangle na text
        end

        def snake_hit_cube?(x,y)
            @cube_x == x && @cube_y == y
        end

        def record_hit 
            @score += 1

        end

        def new_cube(positions)
            new_x = rand(GRID_WIDTH)
            new_y = rand(GRID_HEIGHT)
            positions.each do |x|
                new_cube(positions) if [new_x, new_y] == x
            end
            @cube_x = new_x
            @cube_y = new_y
        end

        def valid_cube?
        end

        def finish
            @finished = true
        end

        def finished?
            @finished
        end

        def text_message_left
            if finished?
            ""
            else
            "Score: #{@score}"
            end
        end

        def text_message_right
            if finished?
            "Game over, your score was: #{@score}. Press R to restart."
            else
            "Press R to restart."
            end
        end
    end
end