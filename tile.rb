require "./board.rb"
class Tile

    def initialize(board, has_mine = false, pos)
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
        adj_mine_count(pos).to_s
    end

    def bomb
        @bombed = true
    end

    def flag
        @flagged = !@flagged
    end

    def adj_mine_count(pos)
        @board.adj_mine_count(pos)
    end
end