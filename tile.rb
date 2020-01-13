require "./board.rb"
class Tile
    attr_reader :has_mine

    def initialize(board, pos, has_mine = false)
        @has_mine = has_mine
        @board = board
        @pos = pos
        @hidden = true
        @flagged = false
        @bombed = false
    end

    def reveal
        @hidden = false
    end

    def to_s
        state
    end

    def state
        return "*" if @hidden
        return "F" if @flagged && (@bombed == false)
        adj_mine_count.to_s
    end

    def bomb
        @bombed = true
    end

    def flag
        @flagged = !@flagged
    end

    def adj_mine_count
        @board.adj_mine_count(@pos)
    end
end