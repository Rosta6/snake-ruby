require 'ruby2d'

set background: 'navy'
#how fast is the snake
set fps_cap: 15

# width = 640 / 20 = 32p
# height = 480 / 20 = 24p
GRID_SIZE = 20
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE

class Snake
    attr_writer :direction

    def initialize
        @positions = [[2,0],[2,1],[2,2],[2,3]]
        @direction = 'down'
    end

    def draw
        @positions.each do |position|
            Square.new(x: position[0] * GRID_SIZE, y: position[1]*GRID_SIZE, size: GRID_SIZE - 1, color: 'white')
        end
    end

    def move
        @positions.shift
        case  @direction
        when 'down'
            @positions.push(new_coords(head[0], head[1] + 1))
        when 'up'
            @positions.push(new_coords(head[0], head[1] - 1))
        when 'left'
            @positions.push(new_coords(head[0] - 1, head[1]))
        when 'right'
            @positions.push(new_coords(head[0] + 1, head[1]))
        end
    end

    def can_change_direction_to?(new_direction)
        case @direction
            when 'up' then new_direction != 'down'
            when 'down' then new_direction != 'up'
            when 'left' then new_direction != 'right'
            when 'right' then new_direction != 'left'
        end
    end


    private 

    def new_coords(x,y)
        [x % GRID_WIDTH, y % GRID_HEIGHT]
    end

    def head
        @positions.last
    end
end

class Game
    def initialize
        @score = 0
        @cube_x = rand(GRID_WIDTH)
        @cube_y = rand(GRID_HEIGHT)
    end

    def draw
        Square.new(x: @cube_x * GRID_SIZE, y: @cube_y * GRID_SIZE, size: GRID_SIZE , color: 'red')
        Text.new('Score: '+ @score.to_s, color: 'green', x: 10, y: 10, size: 25)
    end
end

snake = Snake.new
game = Game.new


update do
    clear

    snake.move
    snake.draw
    game.draw
end

#read key from keyboard
on :key_down do |event|
    if['up','down','left','right'].include?(event.key)
        if snake.can_change_direction_to?(event.key)
        snake.direction = event.key
        end
    end
end


show

