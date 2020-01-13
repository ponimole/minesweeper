require "./tile.rb"
require "byebug"
class Board

    def initialize(size)
        @grid = Array.new(size) {Array.new(size)}
    end

    def populate
        @grid = @grid.map do |row|
            row.map do |tile|
                tile = Tile.new(self)
            end
        end
    end

    def render
        @grid.each do |row|
            print_row = ""
            row.each {|tile| print_row += tile.to_s + " " }
            puts print_row[0...-1]
        end
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

    def valid?(pos)
        x,y = pos
        x.between?(0,@grid.length - 1) || y.between?(0,@grid.length - 1)
    end
end