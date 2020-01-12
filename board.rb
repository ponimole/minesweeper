require "./tile.rb"
require "byebug"
class Board

    def initialize(size)
        @grid = Array.new(size) {Array.new(size)}
    end

    def populate
        @grid = @grid.map do |row|
            row.map do |tile|
                tile = Tile.new
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
end