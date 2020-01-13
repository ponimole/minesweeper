require "./board.rb"
class Game

    def initialize(size)
        @board = Board.new(size)
    end

    def play_loop
        pos = get_pos
    end

    def get_pos
        pos = nil
        begin
            promt_pos
            pos = (gets.chomp).map {|coor| Integer(coor)}
            raise if !valid?(pos)
        rescue
            puts "Invalid position."
            pos = nil
        end
        pos
    end

    def promt_pos
        puts "Please enter a position. Ex. (2,1) : "
    end

    def valid?(pos)
        return false if pos.length != 2
        x,y = pos
        x.between?(0,@gboard.length - 1) && y.between?(0,@Board.length - 1)
    end
end