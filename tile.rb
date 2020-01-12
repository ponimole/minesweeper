class Tile

    def initialize(mine = false)
        @mine = mine
        @hidden = true
    end

    def reveal
        @hidden = false
    end

end