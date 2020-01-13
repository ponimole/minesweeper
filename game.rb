require "./board.rb"
class Game

    def initialize(size)
        @board = Board.new(size)
    end

    def play_loop
        promt_pos
    end


end