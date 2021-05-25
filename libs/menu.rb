module SnakeGame
    class MainMenu
        def initialize
            p "this is brand new main menu"
        end

        def draw_shapes
            Rectangle.new(x: (GRID_WIDTH * GRID_SIZE) / 2 - 100, y: 150,width: 200, height: 70,color: 'white')
        end
        def draw_text
        end

        def click_inside?(x,y)
        end
    end
end