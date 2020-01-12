require "./tile.rb"
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
end