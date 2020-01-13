require "./board.rb"
class Tile

    def initialize(board, has_mine = false)
        @has_mine = has_mine
        @board = board
        @hidden = true
        @flagged = false
        @fringed = false
    end

    def reveal
        @hidden = false
    end

    def to_s
        return " " if @fringed
        return "*" if @hidden
        return "F" if @flagged
    end
end