require "./board.rb"
require "colorize"
class Tile
    attr_reader :has_mine, :hidden

    def initialize(board, pos, has_mine = false)
        @has_mine = has_mine || random_bool
        @board = board
        @pos = pos
        @hidden = true
        @flagged = false
        @bombed = false
    end

    def reveal
        bomb
        @hidden = false
        to_s
    end

    def to_s
        state
    end

    def state
        return "F".colorize(:light_blue) if @flagged && @hidden
        return "*" if @hidden
        return "M".colorize(:red) if has_mine
        adj_mine_count.to_s.colorize(:green)
    end

    def cursor
        return "F".blue.on_red.blink if @flagged && @hidden
        return "*".blue.on_red.blink if @hidden
        return "M".blue.on_red.blink if has_mine
        adj_mine_count.to_s.blue.on_red.blink
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

    def random_bool
        rand(100) % 5 == 0 # 20% percent true
    end
end