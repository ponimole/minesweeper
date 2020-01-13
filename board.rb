require "./tile.rb"
require "./keypress.rb"
require "byebug"
require "yaml"
class Board

    def initialize(size, saved_grid = nil)
        @grid = Array.new(size) {Array.new(size)}
        if saved_grid == nil
            self.populate
        else
            @grid = load_grid(saved_grid)
        end
        @cursor_position = [0,0]
    end

    def get_grid
        @grid.map do |row|
            row.map {|tile|tile}
        end
    end

    def load_grid(saved_grid)
        saved_grid.map do |row|
            row.map {|tile|tile}
        end
    end

    def populate
        @grid = @grid.each_with_index do |row,row_i|
            row.each_with_index do |tile,col_i|
                pos = [col_i,row_i]
                @grid[col_i][row_i] = Tile.new(self,pos)
            end
        end
    end

    def render
        puts "MINESWEEPER"
        puts
        @grid.each_with_index do |row,row_i|
            print_row = ""
            row.each_with_index do |tile,col_i|
                if @cursor_position != [col_i,row_i]
                    print_row += tile.to_s + " "
                else
                    print_row += tile.cursor + " "
                end
            end
            puts print_row[0...-1]
        end
    end

    def get_pos
        row, col = @cursor_position
        
        pos = [col,row]
        case update_pos
        when "UP"
            col -= 1
        when "DOWN"
            col += 1
        when "LEFT"
            row -= 1
        when "RIGHT"
            row += 1
        when "ENTER"
            return pos
        end
        pos = [col,row]
        @cursor_position = [row, col] if valid_coor?(col) && valid_coor?(row)
        system "clear"
        render
        nil
    end

    def [](pos)
        x,y = pos
        @grid[x][y].to_s
    end

    def length
        @grid.length
    end

    def get_adjacents(pos)
        adjacents = []
        x, y = pos
        @grid.each_with_index do |row,row_i|
            row.each_with_index do |tile,col_i|
                if is_adjacent?(x,col_i) &&
                    is_adjacent?(y,row_i) && valid?([col_i,row_i])
                    adjacents << [col_i,row_i]
                elsif (is_adjacent?(x,col_i) && y == row_i) ||
                       (is_adjacent?(y,row_i) && x == col_i) && valid?([col_i,row_i])
                    adjacents << [col_i,row_i]
                end
            end
        end
        adjacents
    end

    def is_adjacent?(coor_1,coor_2)
        coor_1 - coor_2 == 1 || coor_1 - coor_2 == -1
    end

    def valid_coor?(coor)
        coor.between?(0,@grid.length - 1)
    end

    def valid?(pos)
        x,y = pos
        x.between?(0,@grid.length - 1) || y.between?(0,@grid.length - 1)
    end

    def adj_mine_count(pos)
        get_adjacents(pos).count do |pos|
            x,y = pos
            @grid[x][y].has_mine
        end
    end

    def flag(pos)
        if valid?(pos)
            x,y = pos
            @grid[x][y].flag
        end
    end

    def reveal(pos)
        if valid?(pos)
            x,y = pos
            @grid[x][y].reveal
        end
    end

    def lose?
        @grid.any? do |row|
            row.any? {|tile| !tile.hidden if tile.has_mine}
        end
    end

    def win?
        @grid.all? do |row|
            row.all? do |tile|
                if !tile.has_mine
                    !tile.hidden
                else
                    true
                end
            end
        end
    end
end