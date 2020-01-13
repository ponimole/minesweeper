require "./board.rb"
require "byebug"
class Game

    def initialize(size)
        @board = Board.new(size)
    end

    def run
        play_loop
        game_over_prompt
    end

    def play_loop
        @board.render
        win = false
        lose = false
        
        until win || lose
            pos = get_pos
            action = get_act
            @board.reveal(pos)
            if @board.lose?
                lose = true
                lose_prompt
            elsif @board.win?
                win = true
                win_prompt
            end
            @board.render
        end
    end

    def game_over_prompt
        puts "Game over."
    end

    def lose_prompt
        puts "You lose."
    end

    def win_prompt
        put "You Win!!!"
    end

    def get_act
        act = nil
        until act != nil
            begin
                prompt_act
                act = gets.chomp
                raise if !valid_act?(act)
            rescue
                puts "Invalid action"
                act = nil
            end
        end
    end

    def get_pos
        pos = nil
        until pos != nil
            begin
                promt_pos
                pos = (gets.chomp).split(",").map {|coor| Integer(coor)}
                raise if !valid_pos?(pos)
            rescue
                puts "Invalid position."
                pos = nil
            end
        end
        pos
    end

    def prompt_act
        puts "Enter 'B' to Bomb or 'F' to Flag"
    end

    def promt_pos
        puts "Please enter a position. Ex. (2,1) : "
    end

    def valid_pos?(pos)
        return false if pos.length != 2
        x,y = pos
        x.between?(0,@board.length - 1) && y.between?(0,@board.length - 1)
    end

    def valid_act?(act)
        actions = ["B", "F"]
        act.length == 1 && actions.include?(act)
    end
end