class Tile

    def initialize(mine = false)
        @mine = mine
        @hidden = true
        @flagged = false
        @fringed = false
    end

    def reveal
        @hidden = false
    end

    def to_s
        return "1" if @fringed
        return "*" if @hidden
        return "F" if @flagged
    end
end